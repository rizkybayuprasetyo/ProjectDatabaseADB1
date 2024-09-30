/* Add Constraint */
-- insert constraint into supplier table
ALTER TABLE supplier
ADD CONSTRAINT chk_supplier_id CHECK (idsupplier LIKE 'SUP%');
-- insert constraint into MaterialGoods table
ALTER TABLE MaterialGoods
ADD CONSTRAINT chk_material_id CHECK (idmaterial LIKE 'MGD%');
-- insert constraint into PurchaseGoods table
ALTER TABLE PurchaseGoods
ADD CONSTRAINT chk_metodepembayaran CHECK (metodepembayaran IN ('Transfer Bank', 'QRIS', 'Cash'));
ALTER TABLE PurchaseGoods
ADD CONSTRAINT chk_purchase_id CHECK (idpembelian LIKE 'PGD%');
-- insert constraint into Category table
ALTER TABLE Category
ADD CONSTRAINT chk_namakategori CHECK (namakategori IN ('Sayuran', 'Daging', 'Telur', 'Nasi', 'Minuman'));
ALTER TABLE Category
ADD CONSTRAINT chk_category_id CHECK (idkategori LIKE 'CAT%');
-- insert constraint into FinishedGoods table
ALTER TABLE FinishedGoods
ADD CONSTRAINT chk_fgd_id CHECK (REGEXP_LIKE(idproduk, '^FGD[0-9]{7}$'));
-- insert constraint into Customer table
ALTER TABLE Customer
ADD CONSTRAINT chk_cus_id CHECK (REGEXP_LIKE(idcustomer, '^CUS[0-9]{7}$'))
ALTER TABLE Customer
ADD CONSTRAINT chk_gender CHECK (gender IN ('Male', 'Female'));
-- insert constraint into Payment table
ALTER TABLE Payment
ADD CONSTRAINT chk_pay_id CHECK (REGEXP_LIKE(idpayment, '^PAY[0-9]{7}$'))
-- insert constraint into Qris table
ALTER TABLE Qris
ADD CONSTRAINT chk_qris_kode CHECK (REGEXP_LIKE(kodeqris, '^QRIS[0-9]{8}$'))
-- insert constraint into Karyawan table
ALTER TABLE Karyawan
ADD CONSTRAINT chk_krw_id CHECK (REGEXP_LIKE(idkaryawan, '^KRW[0-9]{7}$'));
ALTER TABLE Karyawan
ADD CONSTRAINT chk_email_format CHECK (REGEXP_LIKE(emailkaryawan, '^[A-Za-z0-9._%+-]+@gmail.com$'));
-- insert constraint into JobDescription table
ALTER TABLE JobDescription
ADD CONSTRAINT chk_job_id CHECK (REGEXP_LIKE(idjob, '^JDC[0-9]{7}$'));
-- insert constraint into SalesTransaction table
ALTER TABLE SalesTransaction
ADD CONSTRAINT chk_sales_id CHECK (REGEXP_LIKE(idpenjualan, '^STR[0-9]{7}$'));

/* Create Views */
-- Supplier View [Simple View]
CREATE VIEW view_Supplier AS
SELECT *
FROM Supplier
-- MaterialGoods stock View (MaterialGoods) [Simple View]
CREATE VIEW view_MaterialGoods_Stock AS
SELECT Namaproduk, jumlahstock, satuan
FROM MaterialGoods
-- PurchaseGoods view [Simple View]
CREATE VIEW view_PurchaseGoods AS
SELECT * 
FROM PurchaseGoods
-- PurchaseDetail view [Simple View]
CREATE VIEW view_PurchaseDetail AS
SELECT * 
FROM PurchaseDetail
-- category view [Simple View]
CREATE VIEW view_Category AS
SELECT * 
FROM Category
-- FinishedGoods view [Simple View]
CREATE VIEW view_FinishedGoods AS
SELECT * 
FROM FinishedGoods
-- Conversion view [Simple View]
CREATE VIEW view_Conversion AS
SELECT * 
FROM Conversion
-- Customer Address view (Customer) [Simple View]
CREATE VIEW view_Customer_Address AS
SELECT IDCustomer, AlamatCustomer
FROM Customer
-- Payment view [Simple View]
CREATE VIEW view_Payment AS
SELECT *
FROM payment
-- Qris view [Simple View]
CREATE VIEW view_Qris AS
SELECT *
FROM Qris
-- Cash view [Simple View]
CREATE VIEW view_Cash AS
SELECT *
FROM Cash
-- Karyawan View [simple view]
CREATE VIEW view_Karyawan AS
SELECT *
FROM Karyawan
-- job description view [simple view]
CREATE VIEW view_Karyawan AS
SELECT *
FROM Karyawan
-- Combined Sales View multiple (Sales transaction + sales detail) [Complex view]
CREATE VIEW view_Combined_Sales_Multiple AS
SELECT idpenjualan, tanggalpenjualan, UPPER(metodepembayaran) AS pembayaran , cus_idcustomer, payment_idpayment, fgd_idproduk, quantity
FROM SalesTransaction st JOIN SalesDetail sd ON st.idpenjualan = sd.str_idpenjualan
WHERE Quantity >=2

/* Create Sequence */
CREATE SEQUENCE idsuppliersequence
INCREMENT BY 1
START WITH 1
MAXVALUE 99999
NOCACHE
NOCYCLE;

CREATE SEQUENCE idmaterialsequence
INCREMENT BY 1
START WITH 1
MAXVALUE 99999
NOCACHE
NOCYCLE;

CREATE SEQUENCE idpurchasesequence
INCREMENT BY 1
START WITH 1
MAXVALUE 99999
NOCACHE
NOCYCLE;

CREATE SEQUENCE idcategorysequence
INCREMENT BY 1
START WITH 1
MAXVALUE 99999
NOCACHE
NOCYCLE;

CREATE SEQUENCE idfinishedsequence
INCREMENT BY 1
START WITH 1
MAXVALUE 99999
NOCACHE
NOCYCLE;

CREATE SEQUENCE idcustomersequence
INCREMENT BY 1
START WITH 1
MAXVALUE 99999
NOCACHE
NOCYCLE;

CREATE SEQUENCE idpaymentsequence
INCREMENT BY 1
START WITH 1
MAXVALUE 99999
NOCACHE
NOCYCLE;

CREATE SEQUENCE idkaryawansequence
INCREMENT BY 1
START WITH 1
MAXVALUE 99999
NOCACHE
NOCYCLE;

CREATE SEQUENCE idjobsequence
INCREMENT BY 1
START WITH 1
MAXVALUE 99999
NOCACHE
NOCYCLE;

CREATE SEQUENCE idsalessequence
INCREMENT BY 1
START WITH 1
MAXVALUE 99999
NOCACHE
NOCYCLE;

/* Create Indexs */
--Unique Indexes
CREATE UNIQUE INDEX customer_nohp_uk ON customer (nohp);
CREATE UNIQUE INDEX karyawan_emailkaryawan_uk ON karyawan (emailkaryawan);
--Non-unique Indexes
CREATE INDEX category_namakategori_idx ON category (namakategori);
CREATE INDEX finishedgoods_namaproduk_idx ON finishedgoods (namaproduk);
CREATE INDEX salestransaction_tanggalpenjualan_idx ON salestransaction (tanggalpenjualan);
--Function-based Indexes
CREATE INDEX customer_nama_upper_idx ON customer (UPPER(nama));
--Composite Indexes
CREATE INDEX salestransaction_metodepembayaran_tanggalpenjualan_idx ON salestransaction (metodepembayaran, tanggalpenjualan);

/* CREATE SYNONYMS */
CREATE SYNONYM Supp
FOR Supplier

CREATE SYNONYM Mat_gd
FOR MaterialGoods

CREATE SYNONYM Pur_gd
FOR PurchaseGoods

CREATE SYNONYM Pur_dtl
FOR PurchaseDetail

CREATE SYNONYM Cat
FOR Category

CREATE SYNONYM Fin_gd
FOR FinishedGoods

CREATE SYNONYM Conv
FOR Conversion

CREATE SYNONYM Cus
FOR Customer

CREATE SYNONYM Pay
FOR Payment

CREATE SYNONYM Qr
FOR Qris

CREATE SYNONYM cs
FOR Cash

CREATE SYNONYM Kryw
FOR Karyawan

CREATE SYNONYM jobDesc
FOR JobDescription

CREATE SYNONYM sa_trs
FOR SalesTransaction

CREATE SYNONYM sa_dtl
FOR SalesDetail

CREATE SYNONYM view_mats_stocks
FOR VIEW_MATERIALGOODS_STOCK

CREATE SYNONYM view_combo
FOR VIEW_COMBINED_SALES

CREATE SYNONYM view_cAddress
FOR VIEW_CUSTOMER_ADDRESS