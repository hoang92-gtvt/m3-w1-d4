create database Quanlykho;
use quanlykho;

create table VATTU(
                      MaVT int primary key auto_increment,
                      TenVT nvarchar(30),
                      Donvitinh nvarchar(10),
                      GiaVT int
);

create table KhoVatTu(
                         STT int primary key auto_increment,
                         MaVT int not null,
                         SLVT int ,
                         SLNHAP int,
                         SLXUAT int,
                         FOREIGN KEY (MaVT) references VATTU(MAVT)
);


create table NhaCungCap(
                           IDNCC int primary key auto_increment,
                           MaNCC  varchar(30) not null,
                           TenNCC nvarchar(50)not null,
                           DiaChi nvarchar(100),
                           Phone nvarchar(12)

);
create table DonDH(
                      SoDH int primary key auto_increment,
                      MaDH varchar(30) not null,
                      NgayDH date,
                      IDNCC int(10) not null,
                      foreign key (IDNCC) references NhaCungCap(IDNCC)

);

create table ChitietDH(
                          NumberDH varchar(5) primary key ,
                          SoDH int not null,
                          MaVT int not null,
                          Soluong int,
                          foreign key (SoDH) references DonDH(SoDH),
                          foreign key (MaVT) references VATTU(MaVT)
);

create table PhieuNhap(
                          SoPN int primary key auto_increment,
                          MaPN varchar(10) not null unique ,
                          NgayNhap date,
                          SoDH int not null,
                          foreign key (SoDH) references DonDH(SoDH)


);
create table PhieuXuat(
                          SoPX int primary key auto_increment,
                          MaPX varchar(10) not null unique ,
                          NgayXuat date,
                          TenKH nvarchar(20)
);

create table ChiTietPN(
                          NumberPN varchar(30) not null,
                          SoPN int not null,
                          MaVT int not null,
                          Soluong int not null,
                          GiaNhap int not null,
                          Note nvarchar(50),
                          foreign key (MaVT) references VATTU(MaVT),
                          foreign key (SoPN)references PhieuNhap(SoPN)
);

create table ChiTietPX(
                          NumberPX varchar(30) not null,
                          SoPx int not null,
                          MaVT int not null,
                          Soluong int not null,
                          GiaXuat int not null,
                          Note nvarchar(50),
                          foreign key (MaVT) references VATTU(MaVT),
                          foreign key (SoPX)references PhieuXuat(SoPX)
);

insert into VATTU(tenvt, donvitinh, giavt) value
    ('Kim cắt', 'cái', 20.000),
('Kéo', 'cái', 30.000),
('Dây Điện', 'cuộn', 200.000),
('Mũ', 'chiêc', 50.000),
('Quần áo bảo hộ', 'bộ', 150.000),
('Giày bảo hộ', 'đôi', 300000),
('Thước', 'cái', 10.000);





insert into KhoVatTu(MaVT, SLVT, SLNHAP, SLXUAT) value
    (1, 10, 100, 90),
(3, 20, 100, 80),
(5, 15, 100, 85),
(2, 10, 100, 90),
(4, 25, 100, 75);


insert into NhaCungCap(MaNCC, TenNCC, DiaChi, Phone) value
    ('NCC001', 'Trung tâm 1', 'Ha Noi', 0984-781-128),
    ('NCC002', 'Trung tâm 2', 'Ha Nam', 0986-223-678),
    ('NCC003', 'Trung tâm 3', 'Hai Phong', 0982-124-369);


insert into DonDH(MaDH, NgayDH, IDNCC) value
    ('DH01', '2021-05-19', 2),
    ('DH02', '2021-05-19', 1),
    ('DH03', '2021-05-19', 3),
    ('DH04', '2021-05-19', 2),
    ('DH05', '2021-05-20', 3),
    ('DH06', '2021-05-20', 3);

insert into PhieuNhap(MaPN, NgayNhap, SoDH) value
    ('PN01','2021-05-23','1'),
('PN02','2021-05-24','2'),
('PN03','2021-05-25','3');

insert into PhieuXuat(MaPX, NgayXuat, TenKH) value
    ('PX01','2021-05-20','Khách hàng A' ),
('PX02','2021-05-20','Khách hàng B' ),
('PX03','2021-05-20','Khách hàng C' ),
('PX04','2021-05-22','Khách hàng A' );

insert into chitietdh(NumberDH, SoDH, MaVT, Soluong) value
    ('19.05.01',1, 2, 100),
    ('19.05.02',2, 1, 100),
    ('19.05.03',3, 3, 100),
    ('19.05.04',4, 6, 100),
    ('19.05.05',5, 7, 100),
    ('20.05.01',2, 6, 100);


alter table chitietdh
    add constraint unique (SoDH);

alter table chitietdh
    change  SoDH SoDH int   ;

alter table chitietdh
    add constraint foreign key (SoDH) references DonDH(SoDH);

insert into chitietpn(numberpn, sopn, mavt, soluong, gianhap, note) value
    ('1', 1, 2,100,30,'Don hang 01'),
('2', 2, 1,100,20,'Don hang 02'),
('3', 3, 3,100,200,'Don hang 03'),
('4', 2, 6,100,300,'Don hang 04'),
('5', 1, 7,100,10,'Don hang 05'),
('6', 3, 6,80,300,'Don hang 02');

insert into chitietPx(numberpx, sopx, mavt, soluong, giaxuat, note) value
    ('1',1, 3 ,3,220,'tang10%'),
('2',2, 4 ,4,55,'tang10%'),
('3',3, 2 ,5,33,'tang10%'),
('4',4, 6 ,6,330,'tang10%'),
('5',3, 7 ,7,11,'tang10%'),
('6',1, 2 ,3,33,'tang10%');


select PhieuNhap.SoPN , PhieuNhap.MaPN, MaVT, Soluong, GiaNhap, GiaNhap*soluong as Thanhtien
from chitietpn
         join PhieuNhap on ChiTietPN.SoPN = PhieuNhap.SoPN;

select PhieuNhap.SoPN , PhieuNhap.MaPN, ChiTietPN.MaVT, V.TenVT, Soluong, GiaNhap, GiaNhap*soluong as Thanhtien
from chitietpn
         join PhieuNhap on ChiTietPN.SoPN = PhieuNhap.SoPN
         join VATTU V on ChiTietPN.MaVT = V.MaVT
;

select PhieuNhap.SoPN , PhieuNhap.MaPN, PhieuNhap.SoDH, PhieuNhap.NgayNhap, ChiTietPN.MaVT, V.TenVT, Soluong, GiaNhap, GiaNhap*soluong as Thanhtien
from chitietpn
         join PhieuNhap on ChiTietPN.SoPN = PhieuNhap.SoPN
         join VATTU V on ChiTietPN.MaVT = V.MaVT
;

select PhieuNhap.SoPN , PhieuNhap.MaPN, PhieuNhap.SoDH, PhieuNhap.NgayNhap,NCC.TenNCC, ChiTietPN.MaVT, V.TenVT, Soluong, GiaNhap, GiaNhap*soluong as Thanhtien
from chitietpn
         join PhieuNhap on ChiTietPN.SoPN = PhieuNhap.SoPN
         join VATTU V on ChiTietPN.MaVT = V.MaVT
         join DonDH DD on PhieuNhap.SoDH = DD.SoDH
         join NhaCungCap NCC on DD.IDNCC = NCC.IDNCC
;

select * ,soluong*Gianhap as thanhtien
from ChiTietPN
where soluong>=5
;

select * ,soluong*Gianhap as thanhtien
from ChiTietPN
where ChitietPN.MaVT= All(select VATTU.MaVT
                          from vattu
                          where vattu.Donvitinh= 'cái')
;

select * ,soluong*Gianhap as thanhtien
from ChiTietPN
         join vattu v on ChiTietPN.MaVT = v.MaVT
where v.Donvitinh= 'cái'
;


select * , soluong*Giaxuat as thanhtien
from chitietpx
;

select *, soluong*Giaxuat as thanhtien
from chitietpx
         join (select VATTU.TenVT, VATTU.MaVT
               from VATTU)as VT
              On VT.MaVT=ChiTietPX.MaVT
;

select *, soluong*Giaxuat as thanhtien
from chitietpx,(select VATTU.TenVT, VATTU.MaVT
                from VATTU
)as VT
where VT.MaVT=ChiTietPX.MaVT
;

select PhieuXuat.SoPX, TenKH, V.MaVT, TenVT, soluong, GiaXuat
from chitietpx
         join phieuxuat
              on ChiTietPX.SoPx = PhieuXuat.SoPX
         join VATTU V on ChiTietPX.MaVT = V.MaVT

;