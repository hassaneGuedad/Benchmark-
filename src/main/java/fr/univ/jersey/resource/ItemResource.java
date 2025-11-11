package fr.univ.jersey.resource;

import fr.univ.model.Item;
import fr.univ.service.ItemService;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.*;
import org.springframework.stereotype.Component;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;

@Component
@Path("/items")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class ItemResource {

    private final ItemService itemService;

    public ItemResource(ItemService itemService) {
        this.itemService = itemService;
    }

    @GET
    public Response getItems(
            @QueryParam("page") @DefaultValue("0") int page,
            @QueryParam("size") @DefaultValue("20") int size,
            @QueryParam("categoryId") Long categoryId) {

        Pageable pageable = PageRequest.of(page, size);
        Page<Item> result;

        if (categoryId != null) {
            result = itemService.getItemsByCategoryId(categoryId, pageable);
        } else {
            result = itemService.getAllItems(pageable);
        }

        return Response.ok(result).build();
    }

    @GET
    @Path("/{id}")
    public Response getItemById(@PathParam("id") Long id) {
        Item item = itemService.getItemById(id);
        if (item == null) {
            return Response.status(Response.Status.NOT_FOUND).build();
        }
        return Response.ok(item).build();
    }

    @POST
    public Response createItem(Item item, @Context UriInfo uriInfo) {
        Item created = itemService.createItem(item);
        return Response
                .created(uriInfo.getAbsolutePathBuilder().path(String.valueOf(created.getId())).build())
                .entity(created)
                .build();
    }

    @PUT
    @Path("/{id}")
    public Response updateItem(@PathParam("id") Long id, Item item) {
        Item updated = itemService.updateItem(id, item);
        if (updated == null) {
            return Response.status(Response.Status.NOT_FOUND).build();
        }
        return Response.ok(updated).build();
    }

    @DELETE
    @Path("/{id}")
    public Response deleteItem(@PathParam("id") Long id) {
        itemService.deleteItem(id);
        return Response.noContent().build();
    }
}

