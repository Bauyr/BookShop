/* Indexes on basket */
create index index_fk_cus on baskets(customer_id);
create index index_fk_book on baskets(book_id);