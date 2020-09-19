﻿create database SinhVien
create table Khoa
(
	Ma varchar(10) primary key,
	tenKhoa nvarchar(100),
	namThanhLap int
)
create table KhoaHoc
(
	Ma varchar(10) primary key,
	namBatDau int,
	namKetThuc int
)
create table SinhVien
(
	Ma varchar(10) primary key,
	hoTen nvarchar(100),
	namSinh int,
	danToc nvarchar(20),
	maLop varchar(10)
)
create table ChuongTrinh
(
	Ma varchar(10) primary key,
	tenChuongTrinh nvarchar(100)
)
create table MonHoc
(
	Ma varchar(10) primary key,
	tenMonHoc nvarchar(100),
	maKhoa varchar (10)
)
create table KetQua
(
	maSinhVien varchar(10) foreign key references SinhVien(Ma),
	maMonHoc varchar(10) foreign key references MonHoc(Ma),
	lanThi int,
	diem float
)
alter table KetQua
--alter column maSinhvien varchar(10) not null
--alter column maMonHoc varchar(10) not null
--alter column lanthi int not null
add constraint pr_MaSV_maMH_lt primary key (maSinhVien,maMonHoc,lanThi)
create table GiangKhoa
(
	maChuongTrinh varchar(10) foreign key references ChuongTrinh(Ma) not null,
	maKhoa varchar(10) foreign key references Khoa(ma) not null,
	maMonHoc varchar(10) foreign key references MonHoc(Ma) not null,
	namHoc int,
	hocKy int,
	soTietLyThuyet int,
	soTietThucHanh int,
	soTinChi int
)
alter table GiangKhoa
add constraint pk_GK primary key (maChuongTrinh,maKhoa,maMonHoc)
create table Lop
(
	Ma varchar(10) primary key,
	maKhoaHoc varchar(10) foreign key references KhoaHoc(Ma),
	maKhoa varchar(10) foreign key references Khoa(ma),
	maChuongTrinh varchar(10) foreign key references ChuongTrinh(Ma),
	soThuTu int
)

insert Khoa values('CNTT',N'Công nghệ thông tin',1995)
insert Khoa values('VL',N'Vật lý',1970)

insert KhoaHoc values('K2002',2002,2006),('K2003',2003,2007),('K2004',2004,2008)

insert SinhVien values
('0212001',N'Nguyễn Vĩnh An',1984,'Kinh','TH2002/01'),
('0212002',N'Nguyễn Thanh Bình',1985,'Kinh','TH2002/01'),
('0212003',N'Nguyễn Thanh Cường',1984,'Kinh','TH2002/02'),
('0212004',N'Nguyễn Quốc Duy',1983,'Kinh','VL2003/02'),
('0311001',N'Phan Tuấn Anh',1985,'Kinh','VL2003/01'),
('0311002',N'Huỳnh Thanh Sang',1984,'Kinh','VL2003/01')

insert ChuongTrinh values('CQ',N'Chính Qui')

insert MonHoc values('THT01',N'Toán Cao cấp A1','CNTT'),
('VLT01',N'Toán Cao cấp A1','VL'),('THT02',N'Toán rời rạc','CNTT'),
('THCS01',N'Cấu trúc dữ liệu 1','CNTT'),('THCS02',N'Hệ điều hành','CNTT')

insert KetQua values
('0212001','THT01',1,4),('0212001','THT01',2,7),('0212002','THT01',1,8),('0212003','THT01',1,6),
('0212004','THT01',1,9),('0212001','THT02',1,8),('0212002','THT02',1,5.5),('0212003','THT02',1,4),
('0212003','THT02',2,6),('0212001','THCS01',1,6.5),('0212002','THCS01',1,4),('0212003','THCS01',1,7)

insert GiangKhoa values('CQ','CNTT','THT01',2003,1,60,0,5),
('CQ','CNTT','THT02',2003,2,45,0,4),
('CQ','CNTT','THCS01',2004,1,45,30,4)

insert Lop values('TH2002/01','K2002','CNTT','CQ',1),
('TH2002/02','K2002','CNTT','CQ',2),
('VL2003/01','K2003','VL','CQ',1)

--Câu 1
select sv.hoTen, k.tenKhoa
from SinhVien sv join Lop l on sv.maLop = l.Ma join Khoa k on l.maKhoa = k.Ma
where k.tenKhoa = N'Công nghệ thông tin'
--Câu 2
select sv.hoTen,sv.namSinh,year(getdate()) - sv.namSinh age
from SinhVien sv
where year(getdate()) - sv.namSinh < 18
--Câu 3
select sv.hoTen, kq.maMonHoc
from SinhVien sv join Lop l on sv.maLop = l.Ma join KhoaHoc kh on kh.Ma = l.maKhoaHoc
join KetQua kq on kq.maSinhVien = sv.Ma join MonHoc mh on mh.Ma = kq.maMonHoc
where l.maKhoa = 'CNTT' and kh.namBatDau = 2002 and kh.namKetThuc = 2006 and mh.tenMonHoc = N'Cấu trúc dữ liệu 1'
and sv.Ma not in (select maSinhVien from KetQua)
group by sv.hoTen,kq.maMonHoc 
--Câu 4 
select sv.hoTen
from SinhVien sv join KetQua kq on sv.Ma = kq.maSinhVien join MonHoc mh on mh.Ma = kq.maMonHoc
where kq.diem < 5 and kq.lanThi = 1 and mh.tenMonHoc = N'Cấu trúc dữ liệu 1'
--Câu 5 
select sv.hoTen,sv.maLop, l.maKhoaHoc, ct.tenChuongTrinh, SL
from SinhVien sv join Lop l on sv.maLop = l.Ma
join ChuongTrinh ct on l.maChuongTrinh = ct.Ma
join SiSo s on s.maLop = sv.maLop

select sv.maLop, count(sv.maLop) SL into SiSo
from SinhVien sv
group by sv.maLop
--Câu 6 


select * from SiSo
select * from SinhVien
select * from Lop
select * from KhoaHoc
select * from MonHoc
select * from Khoa
select * from ChuongTrinh
select * from KetQua
select * from GiangKhoa

