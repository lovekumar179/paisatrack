package com.app.paisatrack.backend.modules.booking.entity;

import com.app.paisatrack.backend.common.entity.BaseEntity;
import com.app.paisatrack.backend.modules.currency.entity.Currency;
import com.app.paisatrack.backend.modules.user.entity.User;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "books")
public class Book extends BaseEntity {
  private String book_name;

  @ManyToOne(fetch = FetchType.LAZY, optional = false)
  @JoinColumn(name = "user_id", nullable = false)
  private User user;

  @ManyToOne(fetch = FetchType.LAZY, optional = false)
  @JoinColumn(name = "currency_id", nullable = false)
  private Currency currency;

}

