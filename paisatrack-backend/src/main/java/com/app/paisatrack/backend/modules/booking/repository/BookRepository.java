package com.app.paisatrack.backend.modules.booking.repository;

import com.app.paisatrack.backend.modules.booking.entity.Book;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface BookRepository extends JpaRepository<Book, Long> {
}