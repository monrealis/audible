create table files
(
    id int generated always as identity,
    json jsonb
);

insert into files (json)
select pg_read_file('/docker-entrypoint-initdb.d/books.json') ::jsonb;

create table books                             as
select substring(b->>'genre', '.*(?=:)')        genre1,
    substring(b->>'genre', '(?<=:).*')          genre2,
    b->>'author'                                author,
    b->>'title'                                 title,
    (b->>'duration') ::interval                 duration,
    (b->>'rating_count') ::int                  rating_count,
    (b->>'release_date') ::date                 release_date,
    to_date(b->>'purchase_date', 'DD/MM/YYYY')  purchase_date,
    b->>'publisher'                             publisher,
    b->>'genre'                                 genre,
    b->>'filename'                              filename,
    b->>'info_link'                             info_link,
    b->>'author_link'                           author_link,
    b->>'narrated_by'                           narrated_by,
    b->>'download_link'                         download_link,
    (b->>'rating_average') ::numeric            rating_average,
    b->>'asin'                                  asin,
    b->>'summary'                               summary
from(select(jsonb_array_elements(json)) ::jsonb b
        from files) t;
