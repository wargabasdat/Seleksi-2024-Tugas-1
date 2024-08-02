CREATE TABLE branch (
    branch_id INT AUTO_INCREMENT,
    branch_name VARCHAR(255) UNIQUE NOT NULL,
    address TEXT NOT NULL,
    region VARCHAR(50) NOT NULL,
    PRIMARY KEY (branch_id)
);

CREATE TABLE class (
    class_id INT AUTO_INCREMENT,
    class_name VARCHAR(255) UNIQUE NOT NULL,
    category ENUM("STRENGTH", "MIND & BODY", "DANCE", "CARDIO"),
    difficulty ENUM("EASY", "MEDIUM", "MODERATE", "HARD"),
    duration INT,
    PRIMARY KEY (class_id)
);

CREATE TABLE instructor (
    instructor_id INT AUTO_INCREMENT,
    instructor_name VARCHAR(255) NOT NULL,
    PRIMARY KEY (instructor_id)
);

CREATE TABLE member (
    member_id INT AUTO_INCREMENT,
    member_name VARCHAR(255) NOT NULL,
    member_email VARCHAR(255) UNIQUE NOT NULL,
    member_phone VARCHAR(255) UNIQUE NOT NULL,
    membership_expiry DATE NOT NULL,
    home_branch INT,
    height DECIMAL(5, 2),
    weight DECIMAL(5, 2),
    referral_code VARCHAR(255) UNIQUE NOT NULL,
    PRIMARY KEY (member_id),
    FOREIGN KEY (home_branch) REFERENCES branch (branch_id)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);

CREATE TABLE schedule (
    branch_id INT,
    class_datetime DATETIME,
    class_id INT,
    instructor_id INT,
    PRIMARY KEY (branch_id, class_datetime),
    FOREIGN KEY (branch_id) REFERENCES branch(branch_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (class_id) REFERENCES class(class_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (instructor_id) REFERENCES instructor(instructor_id)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);

CREATE TABLE schedule_attendants (
    branch_id INT,
    class_datetime DATETIME,
    member_id INT,
    PRIMARY KEY (branch_id, class_datetime, member_id),
    FOREIGN KEY (branch_id, class_datetime) REFERENCES schedule(branch_id, class_datetime)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (member_id) REFERENCES member(member_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
