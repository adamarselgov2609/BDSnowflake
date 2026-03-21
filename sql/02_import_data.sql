
TRUNCATE source_mock_data;


COPY source_mock_data FROM '/data/MOCK_DATA.csv' DELIMITER ',' CSV HEADER;
COPY source_mock_data FROM '/data/MOCK_DATA (1).csv' DELIMITER ',' CSV HEADER;
COPY source_mock_data FROM '/data/MOCK_DATA (2).csv' DELIMITER ',' CSV HEADER;
COPY source_mock_data FROM '/data/MOCK_DATA (3).csv' DELIMITER ',' CSV HEADER;
COPY source_mock_data FROM '/data/MOCK_DATA (4).csv' DELIMITER ',' CSV HEADER;
COPY source_mock_data FROM '/data/MOCK_DATA (5).csv' DELIMITER ',' CSV HEADER;
COPY source_mock_data FROM '/data/MOCK_DATA (6).csv' DELIMITER ',' CSV HEADER;
COPY source_mock_data FROM '/data/MOCK_DATA (7).csv' DELIMITER ',' CSV HEADER;
COPY source_mock_data FROM '/data/MOCK_DATA (8).csv' DELIMITER ',' CSV HEADER;
COPY source_mock_data FROM '/data/MOCK_DATA (9).csv' DELIMITER ',' CSV HEADER;


SELECT COUNT(*) as total_records FROM source_mock_data;