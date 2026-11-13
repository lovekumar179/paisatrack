package com.app.paisatrack.backend.common.entity;


import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import org.springframework.data.annotation.CreatedBy;
import org.springframework.data.annotation.LastModifiedBy;
import org.springframework.data.jpa.domain.support.AuditingEntityListener;

import java.time.LocalDateTime;

@Getter
@Setter
@MappedSuperclass
@EntityListeners(AuditingEntityListener.class)
public abstract class BaseEntity {

  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  @Column(updatable = false, nullable = false)
  private Long id;

  @Column(name = "is_active", nullable = false, columnDefinition = "boolean default true")
  private Boolean isActive = Boolean.TRUE;

  @Column(name = "is_deleted", nullable = false, columnDefinition = "boolean default false")
  private Boolean isDeleted = Boolean.FALSE;

  @Column(name = "created_at", updatable = false)
  private LocalDateTime createdAt;

  @Column(name = "updated_at")
  private LocalDateTime updatedAt;

  @Column(name = "deleted_at")
  private LocalDateTime deletedAt;

  @CreatedBy
  @Column(name = "created_by", updatable = false)
  private Long createdBy;

  @LastModifiedBy
  @Column(name = "updated_by")
  private Long updatedBy;

  @Column(name = "deleted_by")
  private Long deletedBy;

  @PrePersist
  protected void onCreate() {
    if (this.isActive == null) this.isActive = Boolean.TRUE;
    if (this.isDeleted == null) this.isDeleted = Boolean.FALSE;
    this.createdAt = LocalDateTime.now();
    this.updatedAt = LocalDateTime.now();
  }

  @PreUpdate
  protected void onUpdate() {
    this.updatedAt = LocalDateTime.now();
  }

  public void stampCreateAudit(Long actorId) {
    if (actorId == null) return;
    if (this.createdBy == null) this.createdBy = actorId;
    this.updatedBy = actorId;
  }

  public void stampUpdateAudit(Long actorId) {
    if (actorId == null) return;
    this.updatedBy = actorId;
  }

  public void softDelete(Long deletedById) {
    this.isDeleted = Boolean.TRUE;
    this.isActive = Boolean.FALSE;
    this.deletedAt = LocalDateTime.now();
    this.deletedBy = deletedById;
  }

  /** Reactivate a soft-deleted row (e.g. re-linking a category to a business). */
  public void restore(Long actorId) {
    this.isDeleted = Boolean.FALSE;
    this.isActive = Boolean.TRUE;
    this.deletedAt = null;
    this.deletedBy = null;
    stampUpdateAudit(actorId);
  }
}
