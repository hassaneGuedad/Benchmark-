package fr.univ.jersey.resource;

import fr.univ.model.Item;
import fr.univ.service.CategoryService;
import fr.univ.service.ItemService;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import org.springframework.stereotype.Component;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;

@Component
@Path("/categories/{categoryId}/items")
@Produces(MediaType.APPLICATION_JSON)
public class CategoryItemsResource {

    private final CategoryService categoryService;
    private final ItemService itemService;

    public CategoryItemsResource(CategoryService categoryService, ItemService itemService) {
        this.categoryService = categoryService;
        this.itemService = itemService;
    }

    @GET
    public Response getItemsByCategory(
            @PathParam("categoryId") Long categoryId,
            @QueryParam("page") @DefaultValue("0") int page,
            @QueryParam("size") @DefaultValue("20") int size) {

        // Vérifier que la catégorie existe
        if (categoryService.getCategoryById(categoryId) == null) {
            return Response.status(Response.Status.NOT_FOUND).build();
        }

        Pageable pageable = PageRequest.of(page, size);
        Page<Item> result = itemService.getItemsByCategoryId(categoryId, pageable);
        return Response.ok(result).build();
    }
}

