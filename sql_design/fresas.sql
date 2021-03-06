    DROP TABLE IF EXISTS taxonomy;
    CREATE TABLE taxonomy(
    	   tax_id  INT NOT NULL AUTO_INCREMENT,
	   specie  TEXT NOT NULL,
	   var	   TEXT NOT NULL,
	   PRIMARY KEY (tax_id)
	   ) ENGINE=InnoDB;
    DROP TABLE IF EXISTS scientist;
    CREATE TABLE scientist(
	scientist_id  INT NOT NULL AUTO_INCREMENT,
	mail    VARCHAR(60) NOT NULL,
	first_name VARCHAR (20),
	family_name VARCHAR (20),
	institution VARCHAR (60),
	PRIMARY KEY (scientist_id)
	) ENGINE=InnoDB;

    DROP TABLE IF EXISTS equipment;
    CREATE TABLE equipment(
	eq_id INT NOT NULL AUTO_INCREMENT,
	eq_name  TEXT,
	eq_model VARCHAR(80),
	eq_serial VARCHAR(80),
	provider  TEXT,
	PRIMARY KEY (eq_id)
	)ENGINE=InnoDB;

    DROP TABLE IF EXISTS assay;
    CREATE TABLE assay(
	assay_id INT NOT NULL AUTO_INCREMENT,
	protocol TEXT,
	description TEXT,
	equipment_id INT,
	scientist_id INT,
	PRIMARY KEY (assay_id),
	FOREIGN KEY (equipment_id)
	 REFERENCES equipment(eq_id)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	FOREIGN KEY (scientist_id)
	 REFERENCES scientist(scientist_id)
	ON DELETE CASCADE
	ON UPDATE CASCADE
	) ENGINE=InnoDB;

DROP TABLE IF EXISTS transgene;
CREATE TABLE transgene(
    gene_id  INT NOT NULL AUTO_INCREMENT,
    sequence TEXT,
    modification TEXT,
    symbol   VARCHAR(255) NOT NULL,
    ECC      VARCHAR(255),
    scient_gene_id  INT,
    PRIMARY KEY (gene_id),
    FOREIGN KEY (scient_gene_id)
     REFERENCES scientist(scientist_id)
	ON DELETE CASCADE
	ON UPDATE CASCADE
    ) ENGINE=InnoDB;

    DROP TABLE IF EXISTS germplasm;
    CREATE TABLE germplasm(
	line_id INT NOT NULL AUTO_INCREMENT,
	name    VARCHAR(100) NOT NULL,
	tax_line_id  INT,
	transgene_id INT,
	transgene_2_id INT,
	transgene_3_id INT,
	scientist_id_germ INT,
	date_creation DATE,
	PRIMARY KEY (line_id),
	FOREIGN KEY (tax_line_id)
	 REFERENCES taxonomy(tax_id),
	ON DELETE CASCADE
	ON UPDATE CASCADE,
 	FOREIGN KEY (transgene_id)
	 REFERENCES transgene(gene_id)	
	ON DELETE CASCADE
	ON UPDATE CASCADE,
 	FOREIGN KEY (transgene_2_id)
	 REFERENCES transgene(gene_id)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
 	FOREIGN KEY (transgene_3_id)
	 REFERENCES transgene(gene_id)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	FOREIGN KEY (scientist_id_germ)
	 REFERENCES scientist(scientist_id)
	ON DELETE CASCADE
	ON UPDATE CASCADE
	) ENGINE=InnoDB;
	
    DROP TABLE IF EXISTS control;
    CREATE TABLE control(
	control_id INT NOT NULL AUTO_INCREMENT,
	line_id INT NOT NULL,
	control_line_id INT NOT NULL,
	season YEAR,
	PRIMARY KEY (control_id),
	FOREIGN KEY (line_id)
	 REFERENCES germplasm(line_id)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	FOREIGN KEY (control_line_id)
	 REFERENCES germplasm(line_id)
	ON DELETE CASCADE
	ON UPDATE CASCADE
	) ENGINE=InnoDB;


    DROP TABLE IF EXISTS shape;
    CREATE TABLE shape(
	shape_id INT NOT NULL AUTO_INCREMENT,
	length_value FLOAT,
	width_value  FLOAT,
	ratio	     FLOAT,
	scientist_id INT,
	line_id      INT NOT NULL,
	control_id   INT NOT NULL,
	date         DATE,
	PRIMARY KEY (shape_id),
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

    DROP TABLE IF EXISTS fruit_weight;
    CREATE TABLE fruit_weight(
	weight_id INT NOT NULL AUTO_INCREMENT,
	value FLOAT NOT NULL,
	scientist_id INT,
	line_id      INT NOT NULL,
	control_id   INT NOT NULL,
	date         DATE,
	PRIMARY KEY (weight_id),
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

    DROP TABLE IF EXISTS firmness;
    CREATE TABLE firmness(
	firmness_id INT NOT NULL AUTO_INCREMENT,
	value FLOAT NOT NULL,
	scientist_id INT,
	assay_id  INT,
	line_id      INT NOT NULL,
	control_id   INT NOT NULL,
	date         DATE,
	PRIMARY KEY (firmness_id),
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

    DROP TABLE IF EXISTS s_solids;
    CREATE TABLE s_solids(
	ss_id INT NOT NULL AUTO_INCREMENT,
	value FLOAT NOT NULL,
	scientist_id INT,
	assay_id  INT,
	line_id      INT NOT NULL,
	control_id   INT NOT NULL,
	date         DATE,
	PRIMARY KEY (ss_id),
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

