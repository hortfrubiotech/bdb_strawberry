    DROP TABLE IF EXISTS color;
    CREATE TABLE color(
	color_id INT NOT NULL AUTO_INCREMENT,
	c_value FLOAT NOT NULL,
	h_value FLOAT NOT NULL,
	l_value FLOAT NOT NULL,
	a_value FLOAT NOT NULL,
	b_value FLOAT NOT NULL,
	scientist_id INT,
	assay_id  INT,
	line_id      INT NOT NULL,
	control_id   INT NOT NULL,
	date         DATE,
	PRIMARY KEY (color_id),
	FOREIGN KEY (assay_id)
	 REFERENCES assay(assay_id)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	FOREIGN KEY (scientist_id)
	 REFERENCES scientist(scientist_id)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	FOREIGN KEY (line_id)
	 REFERENCES germplasm(line_id)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	FOREIGN KEY (control_id)
	 REFERENCES control(control_id)
	ON DELETE CASCADE
	ON UPDATE CASCADE		
	) ENGINE=InnoDB;

