CREATE DATABASE quan_ly_vat_tu;
USE quan_ly_vat_tu;
create table nhacc (
    ma_ncc int primary key,
    ten_ncc varchar(50),
    dia_chi varchar(100),
    sdt varchar(20)
);
create table vattu (
    ma_vtu int primary key,
    ten_vtu varchar(50)
);
create table phieu_xuat (
    so_px int primary key,
    ngay_xuat date
);
create table phieu_nhap (
    so_pn int primary key,
    ngay_nhap date
);
create table dondh (
    so_dh int primary key,
    ngay_dh date,
    ma_ncc int,
    foreign key (ma_ncc) references nhacc(ma_ncc)
);
create table ct_phieu_xuat (
    so_px int,
    ma_vtu int,
    dg_xuat double,
    sl_xuat int,
    primary key (so_px, ma_vtu),
    foreign key (so_px) references phieu_xuat(so_px),
    foreign key (ma_vtu) references vattu(ma_vtu)
);
create table ct_phieu_nhap (
    so_pn int,
    ma_vtu int,
    dg_nhap double,
    sl_nhap int,
    primary key (so_pn, ma_vtu),
    foreign key (so_pn) references phieu_nhap(so_pn),
    foreign key (ma_vtu) references vattu(ma_vtu)
);
create table ct_dondh (
    so_dh int,
    ma_vtu int,
    sl_dat int,
    primary key (so_dh, ma_vtu),
    foreign key (so_dh) references dondh(so_dh),
    foreign key (ma_vtu) references vattu(ma_vtu)
);
show tables;

