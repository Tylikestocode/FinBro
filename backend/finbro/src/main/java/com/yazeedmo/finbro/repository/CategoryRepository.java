package com.yazeedmo.finbro.repository;

import com.yazeedmo.finbro.domain.Category;
import org.springframework.data.jdbc.repository.query.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CategoryRepository extends CrudRepository<Category, Long> {

    @Query("SELECT * FROM CATEGORIES WHERE is_user_defined = :boolean")
    List<Category> findAllByUserDefined(@Param("boolean") boolean isUserDefined);

    @Query("SELECT * FROM CATEGORIES WHERE user_id = :user_id")
    List<Category> findAllByUserId(@Param("user_id") Long userId);

    @Query("SELECT * FROM CATEGORIES WHERE type = :type")
    List<Category> findAllByType (@Param("type") String type);

    @Query("SELECT COUNT(*) FROM CATEGORIES WHERE name = :name")
    boolean existsByName (@Param("name") String name);

    @Query("SELECT COUNT(*) FROM CATEGORIES")
    long countTotalCategories();

}
