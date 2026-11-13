package com.app.paisatrack.backend.modules.transaction.repository;

import com.app.paisatrack.backend.modules.transaction.entity.Transaction;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface TransactionRepository extends JpaRepository<Transaction, Long> {
}