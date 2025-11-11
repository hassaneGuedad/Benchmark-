package fr.univ.controller;

import fr.univ.model.Item;
import fr.univ.service.CategoryService;
import fr.univ.service.ItemService;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/categories/{categoryId}/items")
public class CategoryItemsController {

    private final CategoryService categoryService;
    private final ItemService itemService;

    public CategoryItemsController(CategoryService categoryService, ItemService itemService) {
        this.categoryService = categoryService;
        this.itemService = itemService;
    }

    @GetMapping
    public ResponseEntity<Page<Item>> getItemsByCategory(
            @PathVariable Long categoryId,
            @RequestParam(defaultValue = "0") int page,
            @RequestParam(defaultValue = "20") int size) {

        // Vérifier que la catégorie existe
        if (categoryService.getCategoryById(categoryId) == null) {
            return ResponseEntity.notFound().build();
        }

        Pageable pageable = PageRequest.of(page, size);
        return ResponseEntity.ok(itemService.getItemsByCategoryId(categoryId, pageable));
    }
}

