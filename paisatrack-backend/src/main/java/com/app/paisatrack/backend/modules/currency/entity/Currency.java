package com.app.paisatrack.backend.modules.currency.entity;

import com.app.paisatrack.backend.common.entity.BaseEntity;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "currencies")
public class Currency extends BaseEntity {
  private String country_name;
  private String currency_name;

  @Column(nullable = false, unique = true, length = 3)
  private String alphabeticCode;
  private String symbol;
}
