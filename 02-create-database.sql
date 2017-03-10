create table if not exists deliverable_type(
  id uuid DEFAULT uuid_generate_v4(),
  description text not null CONSTRAINT deliverable_type_description_not_empty CHECK (description <> ''),
  CONSTRAINT deliverable_type_type_pk PRIMARY key(id)
);

create table if not exists deliverable(
  id uuid DEFAULT uuid_generate_v4(),
  name text not null CONSTRAINT deliverablename_not_empty CHECK (name <> ''),
  description text, 
  CONSTRAINT deliverable_pk PRIMARY key(id)
);
