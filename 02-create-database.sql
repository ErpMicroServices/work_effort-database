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

create table if not exists work_effort_type(
  id uuid DEFAULT uuid_generate_v4(),
  description text not null CONSTRAINT work_effort_type_description_not_empty CHECK (description <> ''),
  CONSTRAINT work_effort_type_pk PRIMARY key(id)
);

create table if not exists work_effort_purpose_type(
  id uuid DEFAULT uuid_generate_v4(),
  description text not null CONSTRAINT work_effort_purpose_type_description_not_empty CHECK (description <> ''),
  CONSTRAINT work_effort_purpose_type_type_pk PRIMARY key(id)
);

create table if not exists work_effort(
  id uuid DEFAULT uuid_generate_v4(),
  name text not null CONSTRAINT work_effort_name_not_empty CHECK (name <> ''),
  description text,
  scheduled_start_date date,
  scheduled_completion_date date,
  total_expenditure_allowed double precision,
  total_hours_allowed bigint,
  estimate_hourse bigint,
  actual_start timestamp,
  actual_completion timestamp,
  actual_hours double precision,
  special_terms text,
  quantity_to_produce bigint,
  quantity_produced bigint,
  quantity_rejected bigint,
  work_effort_type_id uuid not null references work_effort_type(id),
  work_effort_purpose_type_id uuid not null references work_effort_purpose_type(id),
  CONSTRAINT _pk PRIMARY key(id)
);
