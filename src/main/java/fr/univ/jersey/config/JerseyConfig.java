package fr.univ.jersey.config;

import org.glassfish.jersey.server.ResourceConfig;
import org.springframework.stereotype.Component;
import fr.univ.jersey.resource.CategoryResource;
import fr.univ.jersey.resource.ItemResource;
import fr.univ.jersey.resource.CategoryItemsResource;

@Component
public class JerseyConfig extends ResourceConfig {

    public JerseyConfig() {
        // Enregistrer les ressources
        register(CategoryResource.class);
        register(ItemResource.class);
        register(CategoryItemsResource.class);

        // Activer la sérialisation JSON par défaut
        register(com.fasterxml.jackson.jaxrs.json.JacksonJsonProvider.class);
    }
}

