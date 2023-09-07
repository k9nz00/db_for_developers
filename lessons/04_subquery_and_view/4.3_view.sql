CREATE OR REPLACE VIEW socnetwork(name) as SELECT 'vk' UNION SELECT 'facebook';
CREATE OR REPLACE VIEW socnetwork as SELECT 'vk' UNION SELECT 'facebook'; -- принципиальный момент!! сравни!
CREATE OR REPLACE VIEW socnetwork as SELECT 'vk', 'facebook'; -- принципиальный момент!! сравни!
DROP VIEW socnetwork;
SELECT * FROM socnetwork;