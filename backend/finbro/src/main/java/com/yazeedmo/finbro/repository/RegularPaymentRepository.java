package com.yazeedmo.finbro.repository;

import com.yazeedmo.finbro.domain.RegularPayment;
import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.time.LocalDateTime;
import java.util.List;

@Repository
public interface RegularPaymentRepository extends CrudRepository<RegularPayment, Long> {

    @Query("SELECT * FROM REGULAR_PAYMENTS WHERE next_date = :next_date")
    List<RegularPayment> findDuePayments(@Param("next_date") LocalDateTime today);

    @Query("SELECT * FROM REGULAR_PAYMENTS WHERE user_id = :user_id")
    List<RegularPayment> findAllByUserId(@Param("user_id") Long userId);

    @Query("SELECT COUNT(*) FROM REGULAR_PAYMENTS")
    long countTotalRegularPayments();

}
