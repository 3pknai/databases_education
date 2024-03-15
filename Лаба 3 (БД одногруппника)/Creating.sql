CREATE database `Knitted Toy Store`;
use `Knitted Toy Store`;

CREATE table `site`(
	id_site int not null auto_increment,
    name varchar(26) not null,
    url varchar(80) not null,
    primary key (id_site)
);

CREATE table `administrators`(
	id_administrators int not null auto_increment,
    FIO varchar(50) not null,
    access_rights varchar(30) not null,
    id_site int not null,
    foreign key (id_site) references site (id_site),
    primary key (id_administrators)
);

CREATE table `moderators`(
	id_moderator int not null auto_increment,
    FIO varchar(50) not null,
    access_rights varchar(30) not null,
    id_site int not null,
    foreign key (id_site) references site (id_site),
    primary key (id_moderator)
);

CREATE table `technical support`(
	id_tech_support int not null auto_increment,
    FIO varchar(50) not null,
    access_rights varchar(30) not null,
    id_site int not null,
    foreign key (id_site) references site (id_site),
    primary key (id_tech_support)
);

CREATE table `seller`(
	id_seller int not null auto_increment,
    contact_information varchar(80) not null,
    id_site int not null,
    id_tech_support int not null,
    foreign key (id_site) references site (id_site),
    foreign key (id_tech_support) references `technical support` (id_tech_support),
    primary key (id_seller)
);

CREATE table `product`(
	id_product int not null auto_increment,
    comments varchar(80) not null,
    quantity_in_stock int not null,
    name varchar(26) not null,
    id_seller int not null,
    id_moderator int not null,
    foreign key (id_seller) references seller (id_seller),
    foreign key (id_moderator) references `moderators` (id_moderator),
    primary key (id_product)
);

CREATE table `buyer`(
	id_buyer int not null auto_increment,
    FIO varchar(50) not null,
    email varchar(30) not null,
    id_site int not null,
    id_tech_support int not null,
    foreign key (id_site) references site (id_site),
    foreign key (id_tech_support) references `technical support` (id_tech_support),
    primary key (id_buyer)
);

CREATE table `review`(
	id_review int not null auto_increment,
    text text,
    rating float,
    id_buyer int not null,
    id_product int not null,
    foreign key (id_buyer) references buyer (id_buyer),
    foreign key (id_product) references product (id_product),
    primary key (id_review)
);

CREATE table `basket`(
	id_basket int not null auto_increment,
    capacity int not null,
    id_buyer int not null,
    foreign key (id_buyer) references buyer (id_buyer),
    primary key (id_basket)
);

CREATE table `basket to product`(
	id_basket int not null,
    id_product int not null,
    foreign key (id_product) references product (id_product),
	foreign key (id_basket) references basket (id_basket),
    primary key (id_basket, id_product)
);

CREATE table `order`(
	id_order int not null auto_increment,
    order_date datetime not null,
    id_basket int not null,
    foreign key (id_basket) references basket (id_basket),
    primary key (id_order)
);

CREATE table `stock`(
	id_stock int not null auto_increment,
    address varchar(100) not null,
    capacity int not null,
    id_order int not null,
    foreign key (id_order) references `order` (id_order),
    primary key (id_stock)
);

CREATE table `delivery`(
	id_delivery int not null auto_increment,
    address varchar(100) not null,
    date date,
    id_stock int not null,
    id_buyer int not null,
    foreign key (id_stock) references stock (id_stock),
	foreign key (id_buyer) references buyer (id_buyer),
    primary key (id_delivery)
);