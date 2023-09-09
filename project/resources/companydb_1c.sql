-- Создание таблицы отделов (Departments)
CREATE TABLE Departments (
    department_id INT PRIMARY KEY,
    department_name NVARCHAR(50) NOT NULL,
    CONSTRAINT CHK_Department_Name_Length CHECK (LEN(department_name) <= 50)
);

-- Создание таблицы сотрудников (Employees)
CREATE TABLE Employees (
    employee_id INT PRIMARY KEY,
    first_name NVARCHAR(50) NOT NULL,
    last_name NVARCHAR(50) NOT NULL,
    email NVARCHAR(100),
    department_id INT,
    hire_date DATE,
    CONSTRAINT CHK_Hire_Date CHECK (hire_date <= GETDATE()),
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);

-- Создание таблицы проектов (Projects)
CREATE TABLE Projects (
    project_id INT PRIMARY KEY,
    project_name NVARCHAR(100) NOT NULL,
    start_date DATE,
    end_date DATE,
    department_id INT,
    CONSTRAINT CHK_Project_Dates CHECK (start_date <= end_date),
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);

-- Создание таблицы платежей (Payments)
CREATE TABLE Payments (
    payment_id INT PRIMARY KEY,
    project_id INT NOT NULL,
    payment_date DATE NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    payment_description NVARCHAR(MAX),
    CONSTRAINT CHK_Payment_Amount CHECK (amount >= 0),
    FOREIGN KEY (project_id) REFERENCES Projects(project_id)
);

-- Создание таблицы задач (Tasks)
CREATE TABLE Tasks (
    task_id INT PRIMARY KEY,
    task_name NVARCHAR(100) NOT NULL,
    description NVARCHAR(MAX),
    project_id INT,
    employee_id INT,
    start_date DATE,
    due_date DATE,
    status NVARCHAR(20),
    CONSTRAINT CHK_Task_Status CHECK (status IN ('New', 'In work', 'Done')),
    FOREIGN KEY (project_id) REFERENCES Projects(project_id),
    FOREIGN KEY (employee_id) REFERENCES Employees(employee_id)
);
