

-- Таблиця для замовників
CREATE TABLE customers (
    id INT IDENTITY(1,1) PRIMARY KEY ,  
    name VARCHAR(255) NOT NULL,
    contact_info VARCHAR(255),
    debt DECIMAL(10,2) DEFAULT 0.00
);

-- Таблиця для типів екскурсій
CREATE TABLE type (
    id INT IDENTITY(1,1) PRIMARY KEY ,
    name VARCHAR(255) NOT NULL
);

-- Таблиця для екскурсій
CREATE TABLE excursions (
    id INT IDENTITY(1,1) PRIMARY KEY ,
    date DATE NOT NULL,
    duration INT NOT NULL,  -- Тривалість у годинах
    destination VARCHAR(255) NOT NULL,
    distance_km DECIMAL(6,2) NOT NULL,  -- Відстань у км
    customer_id INT,
    type_id INT,
    num_tourists INT NOT NULL,  -- Кількість екскурсантів
    total_price DECIMAL(10,2) NOT NULL,
    status VARCHAR(255) CHECK (status IN ('запланована', 'оплачена', 'скасована')) NOT NULL,

    FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE SET NULL,
    FOREIGN KEY (type_id) REFERENCES type(id) ON DELETE CASCADE
);

-- Таблиця для платежів
CREATE TABLE payments (
    id INT IDENTITY(1,1) PRIMARY KEY ,
    excursion_id INT,
    amount DECIMAL(10,2) NOT NULL,
    date DATE NOT NULL,

    FOREIGN KEY (excursion_id) REFERENCES excursions(id) ON DELETE CASCADE
);

-- Таблиця для водіїв
CREATE TABLE drivers (
    id INT IDENTITY(1,1) PRIMARY KEY ,
    name VARCHAR(255) NOT NULL,
    license_number VARCHAR(50) UNIQUE NOT NULL,
    status VARCHAR(255) CHECK (status IN ('вільний', 'зайнятий')) NOT NULL,
);

-- Таблиця для автобусів
CREATE TABLE buses (
    id INT IDENTITY(1,1) PRIMARY KEY ,
    capacity INT NOT NULL,  -- Місткість
    fuel_consumption DECIMAL(5,2) NOT NULL,  -- Витрати пального (л/км)
    type_supported INT,
	status VARCHAR(255) CHECK (status IN ('доступний', 'в ремонті', 'на рейсі')) NOT NULL,
    FOREIGN KEY (type_supported) REFERENCES type(id) ON DELETE SET NULL
);

-- Таблиця для зв’язку екскурсій, автобусів та водіїв
CREATE TABLE excursion_buses (
    id INT IDENTITY(1,1) PRIMARY KEY ,
    excursion_id INT,
    bus_id INT,
    driver_id INT,

    FOREIGN KEY (excursion_id) REFERENCES excursions(id) ON DELETE CASCADE,
    FOREIGN KEY (bus_id) REFERENCES buses(id) ON DELETE CASCADE,
    FOREIGN KEY (driver_id) REFERENCES drivers(id) ON DELETE CASCADE
);
