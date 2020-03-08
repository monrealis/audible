create table files
(
    id int generated always as identity,
    json jsonb
);

insert into files (json)
select pg_read_file('/docker-entrypoint-initdb.d/books.json') ::jsonb;

create table books                             as
select b->>'asin'                               asin,
    b->>'genre'                                 genre,
    b->>'title'                                 title,
    b->>'author'                                author,
    b->>'summary'                               summary,
    (b->>'duration') ::interval                 duration,
    b->>'filename'                              filename,
    b->>'info_link'                             info_link,
    b->>'publisher'                             publisher,
    b->>'author_link'                           author_link,
    b->>'narrated_by'                           narrated_by,
    (b->>'rating_count') ::int                  rating_count,
    (b->>'release_date') ::date                 release_date,
    b->>'download_link'                         download_link,
    to_date(b->>'purchase_date', 'DD/MM/YYYY')  purchase_date,
    (b->>'rating_average') ::numeric            rating_average
from(select(jsonb_array_elements(json)) ::jsonb b
        from files) t;
