package com.app.paisatrack.backend.modules.transaction.entity;

import com.app.paisatrack.backend.common.entity.BaseEntity;
import com.app.paisatrack.backend.modules.booking.entity.Book;
import com.app.paisatrack.backend.modules.category.entity.Category;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;
import org.hibernate.annotations.OnDelete;
import org.hibernate.annotations.OnDeleteAction;

import java.math.BigDecimal;
import java.time.LocalDate;

@Getter
@Setter
@Entity
@Table(name = "transactions")
public class Transaction extends BaseEntity {
  @Column(nullable = false, precision = 15, scale = 2)
  private BigDecimal amount;
  private LocalDate transaction_date;
  private String note;

  @ManyToOne(fetch = FetchType.LAZY, optional = false)
  @JoinColumn(name = "book_id", nullable = false)
  @OnDelete(action = OnDeleteAction.CASCADE)
  private Book book;

  @ManyToOne(fetch = FetchType.LAZY, optional = false)
  @JoinColumn(name = "category_id", nullable = false)
  private Category category;
}
