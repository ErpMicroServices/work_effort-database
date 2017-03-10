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
  a_version_of uuid not null references work_effort(id),
  CONSTRAINT work_effort_pk PRIMARY key(id)
);

create table if not exists work_effort_association_type(
  id uuid DEFAULT uuid_generate_v4(),
  description text not null CONSTRAINT work_effort_association_type_description_not_empty CHECK (description <> ''),
  CONSTRAINT work_effort_association_type_pk PRIMARY key(id)
);

create table if not exists work_effort_association(
  id uuid DEFAULT uuid_generate_v4(),
  from_date date not null default current_date,
  thru_date date,
  associated_from uuid not null references work_effort(id),
  associated_to uuid not null references work_effort(id),
  CONSTRAINT work_effort_association_pk PRIMARY key(id)
);

create table if not exists work_effort_role_type(
  id uuid DEFAULT uuid_generate_v4(),
  description text not null CONSTRAINT work_effort_role_type_description_not_empty CHECK (description <> ''),
  CONSTRAINT work_effort_role_type_pk PRIMARY key(id)
);

create table if not exists work_effort_party_assignment(
  id uuid DEFAULT uuid_generate_v4(),
  from_date date not null default current_date,
  thru_date date,
  comment text,
  assigned_to_party_id uuid not null,
  assigned_at_facility_id uuid,
  work_effort_role_type uuid not null references work_effort_role_type(id),
  work_effort_id uuid not null references work_effort(id),
  CONSTRAINT work_effort_party_assignment_pk PRIMARY key(id)
);

create table if not exists work_effort_status_type(
  id uuid DEFAULT uuid_generate_v4(),
  description text not null CONSTRAINT work_effort_status_type_description_not_empty CHECK (description <> ''),
  CONSTRAINT work_effort_status_type_pk PRIMARY key(id)
);

create table if not exists work_effort_status(
  id uuid DEFAULT uuid_generate_v4(),
  datetime timestamp not null default CURRENT_TIMESTAMP,
  work_effort_status_type_id uuid not null references work_effort_status_type(id),
  CONSTRAINT work_effort_status_pk PRIMARY key(id)
);

create table if not exists skill_type(
  id uuid DEFAULT uuid_generate_v4(),
  description text not null CONSTRAINT _type_description_not_empty CHECK (description <> ''),
  CONSTRAINT skill_type_type_pk PRIMARY key(id)
);

create table if not exists party_skill(
  id uuid DEFAULT uuid_generate_v4(),
  years_experience bigint,
  rating text,
  party_id uuid not null,
  skill_type_id uuid not null references skill_type(id),
  CONSTRAINT party_skill_pk PRIMARY key(id)
);
