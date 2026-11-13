package com.app.paisatrack.backend.modules.currency.repository;

import com.app.paisatrack.backend.modules.currency.entity.Currency;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CurrencyRepository extends JpaRepository<Currency, Long> {
}