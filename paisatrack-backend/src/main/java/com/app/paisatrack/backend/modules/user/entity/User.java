package com.app.paisatrack.backend.modules.user.entity;

import com.app.paisatrack.backend.common.entity.BaseEntity;
import com.app.paisatrack.backend.modules.user.enums.UserRole;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "users")
public class User extends BaseEntity {
  private String fullName;
  private String email;
  private String password;
  private String avatarURL;

  @Enumerated(value = EnumType.STRING)
  private UserRole role;
}