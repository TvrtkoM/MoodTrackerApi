-- insert item 5 hours from now
insert into items ("eventTime", "title", "description") values (
  now() + '5 hours'::interval, 'In 5 hours', 'A task awaits you in 5 hours'
);

-- insert item 7 hours from now
insert into items ("eventTime", "title", "description") values (
  now() + '7 hours'::interval, 'In 7 hours', 'A task awaits you in 7 hours'
);

-- insert item 9 hours from now
insert into items ("eventTime", "title", "description") values (
  now() + '9 hours'::interval, 'In 9 hours', 'A task awaits you in 9 hours'
);

-- insert item 1 month from now
insert into items ("eventTime", "title", "description") values (
  now() + '1 month'::interval, 'In 1 month', 'A task awaits you in 1 month'
);

-- insert item 1 month and 3 hours from now
insert into items ("eventTime", "title", "description") values (
  now() + '1 month'::interval + '3 hours'::interval, 'In 1 month and 3 hours', 'A long long time from now'
);

-- insert item 1 month and 5 hours from now
insert into items ("eventTime", "title", "description") values (
  now() + '1 month'::interval + '5 hours'::interval, 'In 1 month and 5 hours', 'A long long time from now'
);

-- insert item in recent history (4 hours ago) without mood rating
insert into items ("createdAt", "eventTime", "title", "description") values (
  now() - '5 hours'::interval,
  now() - '4 hours'::interval,
  '4 hours ago',
  'A task needs rating'
);

-- insert item in recent history (10 hours ago) without mood rating
insert into items ("createdAt", "eventTime", "title", "description") values (
  now() - '12 hours'::interval,
  now() - '10 hours'::interval,
  '10 hours ago',
  'A task needs rating'
);

-- insert item in recent history (month and 3 hours ago) with mood rating
insert into items ("createdAt", "eventTime", "title", "description", "mood") values (
  now() - '1 month'::interval - '10 hours'::interval,
  now() - '1 month'::interval - '3 hours'::interval,
  'A month and 3 hours ago',
  'A task needs rating',
  8
);

-- insert item in recent history (month and 7 hours ago) with mood rating
insert into items ("createdAt", "eventTime", "title", "description", "mood") values (
  now() - '1 month'::interval - '8 hours'::interval,
  now() - '1 month'::interval - '7 hours'::interval,
  'A month and 7 hours ago',
  'You feel better now, be happy',
  6
);

-- insert item in recent history (2 months and 7 hours ago) with mood rating
insert into items ("createdAt", "eventTime", "title", "description", "mood") values (
  now() - '3 months'::interval,
  now() - '2 months'::interval - '7 hours'::interval,
  '2 months and 7 hours ago',
  'You cant rememeber this, don''t you?',
  2
);

-- insert item in recent history (3 month and 2 hours ago) with mood rating
insert into items ("createdAt", "eventTime", "title", "description", "mood") values (
  now() - '3 month'::interval - '8 hours'::interval,
  now() - '3 month'::interval - '2 hours'::interval,
  '3 months and 2 hours ago',
  'You cant rememeber this, don''t you?',
  2
);
