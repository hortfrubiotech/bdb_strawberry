#!/usr/bin/perl -w
#s_solids.pl
use strict;

schema();


sub schema {

    print <<END;
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

END
;
}
