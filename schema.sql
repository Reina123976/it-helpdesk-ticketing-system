-- =====================================================================
-- IT Help Desk & Ticketing Management System — Database Schema
-- Engine: MySQL 8.x (InnoDB, utf8mb4)
-- Matches: docs/erd/IT_Helpdesk_ERD.drawio
-- =====================================================================

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ---------------------------------------------------------------------
-- Reference tables (no dependencies)
-- ---------------------------------------------------------------------

CREATE TABLE Roles (
    RoleId       INT AUTO_INCREMENT PRIMARY KEY,
    RoleName     VARCHAR(50)  NOT NULL UNIQUE,
    Description  VARCHAR(255) NULL,
    CreatedAt    DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

CREATE TABLE Categories (
    CategoryId   INT AUTO_INCREMENT PRIMARY KEY,
    CategoryName VARCHAR(100) NOT NULL UNIQUE,
    Description  VARCHAR(255) NULL,
    IsActive     TINYINT(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB;

CREATE TABLE Priorities (
    PriorityId   INT AUTO_INCREMENT PRIMARY KEY,
    PriorityName VARCHAR(50) NOT NULL UNIQUE,
    SlaHours     INT NULL,
    ColorCode    VARCHAR(10) NULL
) ENGINE=InnoDB;

CREATE TABLE Statuses (
    StatusId     INT AUTO_INCREMENT PRIMARY KEY,
    StatusName   VARCHAR(50) NOT NULL UNIQUE,
    Description  VARCHAR(255) NULL,
    DisplayOrder INT NOT NULL DEFAULT 0
) ENGINE=InnoDB;

-- ---------------------------------------------------------------------
-- Users (depends on Roles)
-- ---------------------------------------------------------------------

CREATE TABLE Users (
    UserId       INT AUTO_INCREMENT PRIMARY KEY,
    RoleId       INT NOT NULL,
    FullName     VARCHAR(150) NOT NULL,
    Email        VARCHAR(150) NOT NULL UNIQUE,
    PasswordHash VARCHAR(255) NOT NULL,
    PhoneNumber  VARCHAR(20)  NULL,
    Department   VARCHAR(100) NULL,
    IsActive     TINYINT(1) NOT NULL DEFAULT 1,
    CreatedAt    DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt    DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_users_role FOREIGN KEY (RoleId) REFERENCES Roles(RoleId)
) ENGINE=InnoDB;

-- ---------------------------------------------------------------------
-- Tickets (depends on Categories, Priorities, Statuses, Users)
-- ---------------------------------------------------------------------

CREATE TABLE Tickets (
    TicketId          INT AUTO_INCREMENT PRIMARY KEY,
    TicketReferenceNo VARCHAR(20) NOT NULL UNIQUE,
    Title              VARCHAR(200) NOT NULL,
    Description        TEXT NOT NULL,
    CategoryId         INT NOT NULL,
    PriorityId         INT NOT NULL,
    StatusId           INT NOT NULL,
    CreatedByUserId    INT NOT NULL,
    AssignedToUserId   INT NULL,
    DueDate            DATETIME NULL,
    CreatedAt          DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt          DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    ResolvedAt         DATETIME NULL,
    ClosedAt           DATETIME NULL,
    IsDeleted          TINYINT(1) NOT NULL DEFAULT 0,
    CONSTRAINT fk_tickets_category   FOREIGN KEY (CategoryId)       REFERENCES Categories(CategoryId),
    CONSTRAINT fk_tickets_priority   FOREIGN KEY (PriorityId)       REFERENCES Priorities(PriorityId),
    CONSTRAINT fk_tickets_status     FOREIGN KEY (StatusId)         REFERENCES Statuses(StatusId),
    CONSTRAINT fk_tickets_creator    FOREIGN KEY (CreatedByUserId)  REFERENCES Users(UserId),
    CONSTRAINT fk_tickets_assignee   FOREIGN KEY (AssignedToUserId) REFERENCES Users(UserId),
    INDEX idx_tickets_status (StatusId),
    INDEX idx_tickets_priority (PriorityId),
    INDEX idx_tickets_assignee (AssignedToUserId)
) ENGINE=InnoDB;

-- ---------------------------------------------------------------------
-- TicketComments (depends on Tickets, Users)
-- ---------------------------------------------------------------------

CREATE TABLE TicketComments (
    CommentId      INT AUTO_INCREMENT PRIMARY KEY,
    TicketId       INT NOT NULL,
    UserId         INT NOT NULL,
    CommentText    TEXT NOT NULL,
    IsInternalNote TINYINT(1) NOT NULL DEFAULT 0,
    CreatedAt      DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt      DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_comments_ticket FOREIGN KEY (TicketId) REFERENCES Tickets(TicketId) ON DELETE CASCADE,
    CONSTRAINT fk_comments_user   FOREIGN KEY (UserId)   REFERENCES Users(UserId),
    INDEX idx_comments_ticket (TicketId)
) ENGINE=InnoDB;

-- ---------------------------------------------------------------------
-- TicketAttachments (depends on Tickets, TicketComments, Users)
-- ---------------------------------------------------------------------

CREATE TABLE TicketAttachments (
    AttachmentId     INT AUTO_INCREMENT PRIMARY KEY,
    TicketId         INT NOT NULL,
    CommentId        INT NULL,
    FileName         VARCHAR(255) NOT NULL,
    FileUrl          VARCHAR(255) NOT NULL,
    FileType         VARCHAR(50) NULL,
    FileSizeKb       INT NULL,
    UploadedByUserId INT NOT NULL,
    UploadedAt       DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_attachments_ticket   FOREIGN KEY (TicketId)         REFERENCES Tickets(TicketId) ON DELETE CASCADE,
    CONSTRAINT fk_attachments_comment  FOREIGN KEY (CommentId)        REFERENCES TicketComments(CommentId) ON DELETE SET NULL,
    CONSTRAINT fk_attachments_uploader FOREIGN KEY (UploadedByUserId) REFERENCES Users(UserId),
    INDEX idx_attachments_ticket (TicketId)
) ENGINE=InnoDB;

-- ---------------------------------------------------------------------
-- Notifications (depends on Users, Tickets)
-- ---------------------------------------------------------------------

CREATE TABLE Notifications (
    NotificationId   INT AUTO_INCREMENT PRIMARY KEY,
    UserId           INT NOT NULL,
    TicketId         INT NULL,
    Title            VARCHAR(150) NOT NULL,
    Message          VARCHAR(255) NOT NULL,
    NotificationType VARCHAR(50) NOT NULL,
    IsRead           TINYINT(1) NOT NULL DEFAULT 0,
    CreatedAt        DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_notifications_user   FOREIGN KEY (UserId)   REFERENCES Users(UserId) ON DELETE CASCADE,
    CONSTRAINT fk_notifications_ticket FOREIGN KEY (TicketId) REFERENCES Tickets(TicketId) ON DELETE SET NULL,
    INDEX idx_notifications_user (UserId, IsRead)
) ENGINE=InnoDB;

-- ---------------------------------------------------------------------
-- ActivityLogs (depends on Users, Tickets)
-- ---------------------------------------------------------------------

CREATE TABLE ActivityLogs (
    LogId             INT AUTO_INCREMENT PRIMARY KEY,
    UserId             INT NOT NULL,
    TicketId           INT NULL,
    ActionType         VARCHAR(50) NOT NULL,
    ActionDescription  VARCHAR(255) NOT NULL,
    OldValue           VARCHAR(255) NULL,
    NewValue           VARCHAR(255) NULL,
    IpAddress          VARCHAR(50) NULL,
    CreatedAt          DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_activitylogs_user   FOREIGN KEY (UserId)   REFERENCES Users(UserId),
    CONSTRAINT fk_activitylogs_ticket FOREIGN KEY (TicketId) REFERENCES Tickets(TicketId) ON DELETE SET NULL,
    INDEX idx_activitylogs_ticket (TicketId)
) ENGINE=InnoDB;

-- ---------------------------------------------------------------------
-- TicketAssignmentHistory (depends on Tickets, Users)
-- ---------------------------------------------------------------------

CREATE TABLE TicketAssignmentHistory (
    AssignmentId       INT AUTO_INCREMENT PRIMARY KEY,
    TicketId           INT NOT NULL,
    AssignedFromUserId INT NULL,
    AssignedToUserId   INT NOT NULL,
    AssignedByUserId   INT NOT NULL,
    AssignmentType     VARCHAR(20) NOT NULL DEFAULT 'Manual', -- Manual | Auto | Escalation
    AssignedAt         DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_assignhist_ticket FOREIGN KEY (TicketId)           REFERENCES Tickets(TicketId) ON DELETE CASCADE,
    CONSTRAINT fk_assignhist_from   FOREIGN KEY (AssignedFromUserId) REFERENCES Users(UserId),
    CONSTRAINT fk_assignhist_to     FOREIGN KEY (AssignedToUserId)   REFERENCES Users(UserId),
    CONSTRAINT fk_assignhist_by     FOREIGN KEY (AssignedByUserId)   REFERENCES Users(UserId),
    INDEX idx_assignhist_ticket (TicketId)
) ENGINE=InnoDB;

-- ---------------------------------------------------------------------
-- KnowledgeBaseArticles (depends on Categories, Users)
-- ---------------------------------------------------------------------

CREATE TABLE KnowledgeBaseArticles (
    ArticleId        INT AUTO_INCREMENT PRIMARY KEY,
    CategoryId       INT NOT NULL,
    AuthorUserId     INT NOT NULL,
    ApprovedByUserId INT NULL,
    Title            VARCHAR(200) NOT NULL,
    Content          TEXT NOT NULL,
    IsApproved       TINYINT(1) NOT NULL DEFAULT 0,
    ViewCount        INT NOT NULL DEFAULT 0,
    CreatedAt        DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt        DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_kb_category FOREIGN KEY (CategoryId)       REFERENCES Categories(CategoryId),
    CONSTRAINT fk_kb_author   FOREIGN KEY (AuthorUserId)     REFERENCES Users(UserId),
    CONSTRAINT fk_kb_approver FOREIGN KEY (ApprovedByUserId) REFERENCES Users(UserId)
) ENGINE=InnoDB;

SET FOREIGN_KEY_CHECKS = 1;
