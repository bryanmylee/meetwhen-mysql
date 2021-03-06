USE lets_meet;
SET GLOBAL time_zone = '+00:00';
SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS `event`;
CREATE TABLE `event` (
    id            INT          NOT NULL AUTO_INCREMENT,
    url_id        VARCHAR(255) UNIQUE, INDEX(url_id(10)),
    title         VARCHAR(255) NOT NULL,
    description   VARCHAR(255) NOT NULL DEFAULT "",
    dtime_created DATETIME     NOT NULL DEFAULT NOW(),
    PRIMARY KEY (id)
);

DROP TABLE IF EXISTS `event_interval`;
CREATE TABLE `event_interval` (
    event_id    INT      NOT NULL,
    start_dtime DATETIME NOT NULL,
    end_dtime   DATETIME NOT NULL,
    PRIMARY KEY (event_id, start_dtime),
    FOREIGN KEY (event_id) REFERENCES `event`(id) ON DELETE CASCADE
);

DROP TABLE IF EXISTS `event_user`;
CREATE TABLE `event_user` (
    event_id      INT          NOT NULL,
    username      VARCHAR(255) NOT NULL,
    password      BINARY(60)   NOT NULL,
    is_admin      BOOLEAN      NOT NULL DEFAULT FALSE,
    refresh_token TEXT,
    PRIMARY KEY (event_id, username),
    FOREIGN KEY (event_id) REFERENCES `event`(id) ON DELETE CASCADE
);

DROP TABLE IF EXISTS `user_interval`;
CREATE TABLE `user_interval` (
    event_id    INT          NOT NULL,
    username    VARCHAR(255) NOT NULL,
    start_dtime DATETIME     NOT NULL,
    end_dtime   DATETIME     NOT NULL,
    PRIMARY KEY (event_id, username, start_dtime),
    FOREIGN KEY (event_id, username)
            REFERENCES `event_user`(event_id, username) ON DELETE CASCADE
);

SET FOREIGN_KEY_CHECKS = 1;