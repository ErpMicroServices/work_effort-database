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

create table if not exists work_effort_purpose_type(
  id uuid DEFAULT uuid_generate_v4(),
  description text not null CONSTRAINT work_effort_purpose_type_description_not_empty CHECK (description <> ''),
  CONSTRAINT work_effort_purpose_type_type_pk PRIMARY key(id)
);

create table if not exists work_effort_association_type(
  id uuid DEFAULT uuid_generate_v4(),
  description text not null CONSTRAINT work_effort_association_type_description_not_empty CHECK (description <> ''),
  CONSTRAINT work_effort_association_type_pk PRIMARY key(id)
);

create table if not exists work_effort_role_type(
  id uuid DEFAULT uuid_generate_v4(),
  description text not null CONSTRAINT work_effort_role_type_description_not_empty CHECK (description <> ''),
  CONSTRAINT work_effort_role_type_pk PRIMARY key(id)
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


create table if not exists timesheet(
  id uuid DEFAULT uuid_generate_v4(),
  from_date date not null default current_date,
  thru_date date,
  comment text,
  CONSTRAINT timesheet_pk PRIMARY key(id)
);

create table if not exists timesheet_role_type(
  id uuid DEFAULT uuid_generate_v4(),
  description text not null CONSTRAINT _type_description_not_empty CHECK (description <> ''),
  CONSTRAINT _type_pk PRIMARY key(id)
);

create table if not exists timesheet_role(
  id uuid DEFAULT uuid_generate_v4(),
  party_id uuid not null,
  described_by uuid not null references timesheet_role_type(id),
  timesheet_id uuid not null references timesheet(id),
  CONSTRAINT timesheet_role_pk PRIMARY key(id)
);

create table if not exists position_type(
  id uuid DEFAULT uuid_generate_v4(),
  description text not null CONSTRAINT position_type_description_not_empty CHECK (description <> ''),
  CONSTRAINT position_type_pk PRIMARY key(id)
);

create table if not exists rate_type(
  id uuid DEFAULT uuid_generate_v4(),
  description text not null CONSTRAINT rate_type_description_not_empty CHECK (description <> ''),
  CONSTRAINT rate_type_pk PRIMARY key(id)
);

create table if not exists position_type_rate(
  id uuid DEFAULT uuid_generate_v4(),
  from_date date not null default current_date,
  thru_date date,
  rate double precision not null,
  position_type_id uuid not null references position_type(id),
  rate_type_id uuid not null references rate_type(id),
  CONSTRAINT position_type_rate_pk PRIMARY key(id)
);

create table if not exists party_rate(
  id uuid DEFAULT uuid_generate_v4(),
  from_date date not null default current_date,
  thru_date date,
  party_id uuid not null,
  rate_type_id uuid not null references rate_type(id),
  CONSTRAINT party_rate_pk PRIMARY key(id)
);

create table if not exists work_effort_asset_assign_status_type(
  id uuid DEFAULT uuid_generate_v4(),
  description text not null CONSTRAINT work_effort_asset_assign_status_type_description_not_empty CHECK (description <> ''),
  CONSTRAINT work_effort_asset_assign_status_type_pk PRIMARY key(id)
);

create table if not exists fixed_asset_type(
  id uuid DEFAULT uuid_generate_v4(),
  description text not null CONSTRAINT fixed_asset_type_description_not_empty CHECK (description <> ''),
  sub_type_of uuid not null references fixed_asset_type(id),
  CONSTRAINT fixed_asset_type_pk PRIMARY key(id)
);

create table if not exists fixed_asset(
  id uuid DEFAULT uuid_generate_v4(),
  name text not null constraint fixed_asset_name_not_empty check( name <> ''),
  date_acquired date,
  date_last_serviced date,
  date_next_service date,
  production_capacity bigint,
  description text,
  unit_of_measure uuid,
  described_by uuid not null references fixed_asset_type( id),
  CONSTRAINT fixed_asset_pk PRIMARY key(id)
);

create table if not exists party_asset_assignment_status_type(
  id uuid DEFAULT uuid_generate_v4(),
  description text not null CONSTRAINT party_asset_assignment_status_type_description_not_empty CHECK (description <> ''),
  CONSTRAINT party_asset_assignment_status_type_pk PRIMARY key(id)
);

create table if not exists party_fixed_asset_assignment(
  id uuid DEFAULT uuid_generate_v4(),
  from_date date not null default current_date,
  thru_date date,
  allocated_cost double precision,
  comment text,
  party_asset_assignment_status_type_id uuid not null references party_asset_assignment_status_type(id),
  CONSTRAINT party_fixed_asset_assignment_pk PRIMARY key(id)
);

create table if not exists work_effort_type(
  id uuid DEFAULT uuid_generate_v4(),
  description text not null CONSTRAINT work_effort_type_description_not_empty CHECK (description <> ''),
  standard_work_hours double precision not null default 1,
  fixed_asset_type_id uuid references fixed_asset_type(id),
  deliverable_type_id uuid references deliverable_type(id),
  product_id uuid,
  CONSTRAINT work_effort_type_pk PRIMARY key(id)
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

create table if not exists work_effort_type_assocation_type(
  id uuid DEFAULT uuid_generate_v4(),
  description text not null CONSTRAINT work_effort_type_assocation_type_description_not_empty CHECK (description <> ''),
  CONSTRAINT work_effort_type_assocation_type_pk PRIMARY key(id)
);

create table if not exists work_effort_type_association(
  id uuid DEFAULT uuid_generate_v4(),
  from_work_effort_type_id uuid not null references work_effort_type(id),
  to_work_effort_type_id uuid not null references work_effort_type(id),
  CONSTRAINT _pk PRIMARY key(id)
);

create table if not exists work_effort_skill_standard(
  id uuid DEFAULT uuid_generate_v4(),
  estimated_number_of_people bigint not null default 1,
  estimated_duration double precision,
  esitmated_cost double precision,
  for_work_effort_type_id uuid not null references work_effort_type(id),
  for_skill_type_id uuid not null references skill_type(id),
  CONSTRAINT work_effort_skill_standard_pk PRIMARY key(id)
);

create table if not exists work_effort_good_standard(
  id uuid DEFAULT uuid_generate_v4(),
  estimated_quantity bigint ,
  estimated_cost double precision,
  for_work_effort_type_id uuid not null references work_effort_type(id),
  for_good_id uuid not null,
  CONSTRAINT work_effort_good_standard_pk PRIMARY key(id)
);

create table if not exists work_effort_good_standard(
  id uuid DEFAULT uuid_generate_v4(),
  estimated_quantity bigint ,
  estimated_duration double precision,
  estimated_cost double precision,
  for_work_effort_type_id uuid not null references work_effort_type(id),
  for_fixed_asset_id uuid not null references fixed_asset(id),
  CONSTRAINT work_effort_good_standard_pk PRIMARY key(id)
);

create table if not exists work_effort_association(
  id uuid DEFAULT uuid_generate_v4(),
  from_date date not null default current_date,
  thru_date date,
  associated_from uuid not null references work_effort(id),
  associated_to uuid not null references work_effort(id),
  CONSTRAINT work_effort_association_pk PRIMARY key(id)
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

create table if not exists time_entry(
  id uuid DEFAULT uuid_generate_v4(),
  from_datetime timestamp not null default current_timestamp,
  thru_datetime timestamp,
  hours double precision,
  comment text,
  timesheet_id uuid not null references timesheet(id),
  spent_on uuid not null references work_effort(id),
  CONSTRAINT time_entry_pk PRIMARY key(id)
);

create table if not exists work_effort_assignment_rate(
  id uuid DEFAULT uuid_generate_v4(),
  from_date date not null default current_date,
  thru_date date,
  rate double precision,
  work_effort_party_assignment_id uuid not null references work_effort_party_assignment(id),
  rate_type_id uuid not null references rate_type(id),
  CONSTRAINT work_effort_assignment_rate_pk PRIMARY key(id)
);

create table if not exists work_effort_inventory_assignment(
  id uuid DEFAULT uuid_generate_v4(),
  quantity bigint not null,
  work_effort_id uuid not null references work_effort(id),
  inventory_id uuid not null,
  CONSTRAINT wok_effort_inventory_assignment_pk PRIMARY key(id)
);

create table if not exists work_effort_fixed_asset_assignment(
  id uuid DEFAULT uuid_generate_v4(),
  from_date date not null default current_date,
  thru_date date,
  allocated_cost double precision,
  comment text,
  work_effort_asset_assign_status_type_id uuid not null references work_effort_asset_assign_status_type(id),
  fixed_asset_id uuid not null,
  work_effort_id uuid not null references work_effort(id),
  CONSTRAINT work_effort_fixed_asset_assignment_pk PRIMARY key(id)
);

create table if not exists work_effort_inventory_produced(
  id uuid DEFAULT uuid_generate_v4(),
  work_effort_id uuid not null references work_effort(id),
  inventory_id uuid not null,
  CONSTRAINT work_effort_inventory_produced_pk PRIMARY key(id)
);

create table if not exists work_effort_deliverable_produced(
  id uuid DEFAULT uuid_generate_v4(),
  work_effort_id uuid not null references work_effort(id),
  deliverable_id uuid not null references deliverable(id),
  CONSTRAINT work_effort_deliverable_produced_pk PRIMARY key(id)
);