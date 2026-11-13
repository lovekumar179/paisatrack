package com.app.paisatrack.backend.modules.category.entity;

import com.app.paisatrack.backend.common.entity.BaseEntity;
import com.app.paisatrack.backend.modules.category.enums.CategoryType;
import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Entity
@Table(name = "categories")
public class Category extends BaseEntity {
  private String category_name;

  @Enumerated(EnumType.STRING)
  @Column(nullable = false, length = 10)
  private CategoryType categoryType;
}
