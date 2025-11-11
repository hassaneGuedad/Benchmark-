package fr.univ.service;

import fr.univ.model.Item;
import fr.univ.repository.ItemRepository;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional
public class ItemService {

    private final ItemRepository itemRepository;

    @Value("${app.use-join-fetch:false}")
    private boolean useJoinFetch;

    public ItemService(ItemRepository itemRepository) {
        this.itemRepository = itemRepository;
    }

    public Page<Item> getAllItems(Pageable pageable) {
        return itemRepository.findAll(pageable);
    }

    public Item getItemById(Long id) {
        return itemRepository.findById(id).orElse(null);
    }

    public Page<Item> getItemsByCategoryId(Long categoryId, Pageable pageable) {
        if (useJoinFetch) {
            return itemRepository.findByCategoryIdWithJoinFetch(categoryId, pageable);
        } else {
            return itemRepository.findByCategoryId(categoryId, pageable);
        }
    }

    public Item createItem(Item item) {
        return itemRepository.save(item);
    }

    public Item updateItem(Long id, Item item) {
        return itemRepository.findById(id)
                .map(existing -> {
                    existing.setSku(item.getSku());
                    existing.setName(item.getName());
                    existing.setPrice(item.getPrice());
                    existing.setStock(item.getStock());
                    existing.setCategory(item.getCategory());
                    return itemRepository.save(existing);
                })
                .orElse(null);
    }

    public void deleteItem(Long id) {
        itemRepository.deleteById(id);
    }
}

