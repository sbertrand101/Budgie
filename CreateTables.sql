CREATE TABLE IF NOT EXISTS ProjUser(
    UserID VARCHAR(40) NOT NULL,
    HashedPassword VARCHAR(255) NOT NULL,
    Salt VARCHAR(10) NOT NULL,
    PRIMARY KEY (UserID)
);

CREATE TABLE IF NOT EXISTS ProjStateTax(
    StateBracketID INT NOT NULL AUTO_INCREMENT,
    StateID CHAR(2) NOT NULL,
    MinIncome INT NOT NULL,
    MaxIncome INT NOT NULL,
    Percent FLOAT NOT NULL,
    PRIMARY KEY (StateBracketID)
);

CREATE TABLE IF NOT EXISTS ProjFedTax(
    FedBracketID INT NOT NULL AUTO_INCREMENT,
    MinIncome INT NOT NULL,
    MaxIncome INT NOT NULL,
    Percent FLOAT NOT NULL,
    PRIMARY KEY (FedBracketID)
);

CREATE TABLE IF NOT EXISTS ProjBudget(
    BudgetID INT NOT NULL AUTO_INCREMENT,
    UserID VARCHAR(40) NOT NULL,
    Salary INT NOT NULL,
    FedBracketID INT NOT NULL,
    StateBracketID INT NOT NULL,
    FOREIGN KEY(UserID) REFERENCES ProjUser(UserID),
    FOREIGN KEY(FedBracketID) REFERENCES ProjFedTax(FedBracketID),
    FOREIGN KEY(StateBracketID) REFERENCES ProjStateTax(StateBracketID),
    PRIMARY KEY(BudgetID)
);

CREATE TABLE IF NOT EXISTS ProjSplit(
    SplitID INT NOT NULL AUTO_INCREMENT,
    BudgetID INT NOT NULL,
    Name VARCHAR(40),
    Percent FLOAT NOT NULL,
    FOREIGN KEY(BudgetID) REFERENCES ProjBudget(BudgetID),
    PRIMARY KEY(SplitID)
);

