-- =====================================================================
-- IT Help Desk & Ticketing Management System — Seed / Sample Data
-- Run AFTER schema.sql, on an empty database.
-- Note: PasswordHash values below are placeholders only — never use
-- these in anything beyond local dev/demo (they are NOT real bcrypt
-- hashes, just fillers so the column isn't empty).
-- =====================================================================

-- ---------------------------------------------------------------------
-- Roles
-- ---------------------------------------------------------------------
INSERT INTO Roles (RoleName, Description) VALUES
('Admin', 'Full system access'),
('IT Support Agent', 'Manages and resolves tickets'),
('Employee', 'Creates and tracks tickets'),
('Manager', 'Monitors team tickets and reports');

-- ---------------------------------------------------------------------
-- Categories
-- ---------------------------------------------------------------------
INSERT INTO Categories (CategoryName, Description) VALUES
('Hardware', 'Laptops, peripherals, and equipment requests'),
('Software', 'OS updates, SaaS licenses, and application issues'),
('Network', 'VPN configuration, WiFi, and firewall issues'),
('Email', 'Mailbox, Outlook, and delivery issues'),
('Access Request', 'IAM, MFA, and SSO troubleshooting'),
('Other', 'Anything that does not fit the above');

-- ---------------------------------------------------------------------
-- Priorities
-- ---------------------------------------------------------------------
INSERT INTO Priorities (PriorityName, SlaHours, ColorCode) VALUES
('Low', 72, '#22C55E'),
('Medium', 24, '#EAB308'),
('High', 8, '#F97316'),
('Critical', 2, '#EF4444');

-- ---------------------------------------------------------------------
-- Statuses
-- ---------------------------------------------------------------------
INSERT INTO Statuses (StatusName, Description, DisplayOrder) VALUES
('Open', 'Newly created, not yet started', 1),
('In Progress', 'Actively being worked on', 2),
('Pending', 'Waiting on the requester or a third party', 3),
('Resolved', 'Fix applied, awaiting confirmation', 4),
('Closed', 'Confirmed resolved and archived', 5);

-- ---------------------------------------------------------------------
-- Users  (RoleId: 1=Admin, 2=Agent, 3=Employee, 4=Manager)
-- ---------------------------------------------------------------------
INSERT INTO Users (RoleId, FullName, Email, PasswordHash, PhoneNumber, Department, IsActive) VALUES
(1, 'Alex Rivera',      'alex.rivera@itops.enterprise',   '$2y$10$placeholderHashAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA', '555-0101', 'System Operations', 1),
(2, 'Marcus Aurelius',  'marcus.aurelius@itops.enterprise','$2y$10$placeholderHashBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB', '555-0102', 'Infrastructure',     1),
(2, 'Linda Hamilton',   'linda.hamilton@itops.enterprise', '$2y$10$placeholderHashCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC', '555-0103', 'Network Operations', 1),
(3, 'Sarah Jenkins',    'sarah.jenkins@itops.enterprise',  '$2y$10$placeholderHashDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD', '555-0104', 'Marketing',          1),
(3, 'John Doe',         'john.doe@itops.enterprise',       '$2y$10$placeholderHashEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE', '555-0105', 'Sales',              1),
(4, 'Jennifer Smith',   'jennifer.smith@itops.enterprise', '$2y$10$placeholderHashFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF', '555-0106', 'Security Operations',1);

-- ---------------------------------------------------------------------
-- Tickets
-- (CategoryId: 1=Hardware 2=Software 3=Network 4=Email 5=Access 6=Other)
-- (PriorityId: 1=Low 2=Medium 3=High 4=Critical)
-- (StatusId:   1=Open 2=In Progress 3=Pending 4=Resolved 5=Closed)
-- ---------------------------------------------------------------------
INSERT INTO Tickets (TicketReferenceNo, Title, Description, CategoryId, PriorityId, StatusId, CreatedByUserId, AssignedToUserId, DueDate) VALUES
('TCK-00001', 'VPN connection timeout for North American region',
 'Users in the North American cluster (NYC, TOR, CHI) are reporting intermittent timeouts when connecting to the VPN gateway. Preliminary logs show a 40% increase in handshake failures.',
 3, 4, 2, 4, 2, DATE_ADD(NOW(), INTERVAL 2 HOUR)),
('TCK-00002', 'Outlook crashing on startup - Windows 11',
 'Outlook crashes immediately on launch after the latest Windows 11 update. Safe mode has not been tried yet.',
 2, 3, 2, 4, 3, DATE_ADD(NOW(), INTERVAL 8 HOUR)),
('TCK-00003', 'Printer setup for new marketing team',
 'New hires on the marketing team need their workstations connected to the 3rd floor network printer.',
 1, 1, 4, 5, 3, NULL),
('TCK-00004', 'Access request for Project Falcon',
 'Requesting read/write access to the Project Falcon shared drive and Jira board.',
 5, 2, 1, 5, NULL, DATE_ADD(NOW(), INTERVAL 24 HOUR)),
('TCK-00005', 'Payment API failing in production',
 'Payment API is returning 500 errors intermittently in production since this morning\'s deploy.',
 2, 4, 1, 6, 2, DATE_ADD(NOW(), INTERVAL 2 HOUR));

-- ---------------------------------------------------------------------
-- TicketComments
-- ---------------------------------------------------------------------
INSERT INTO TicketComments (TicketId, UserId, CommentText, IsInternalNote) VALUES
(1, 4, 'Still unable to connect. This is blocking my access to the staging environment. Any ETA on the fix?', 0),
(1, 2, 'Checked the NA-West gateway and it is saturated. Routing NA-East users to the EU-Central failover temporarily until load balances.', 1),
(2, 3, 'Please try booting into Safe Mode and disabling all add-ins first, then relaunch normally.', 0);

-- ---------------------------------------------------------------------
-- TicketAttachments
-- ---------------------------------------------------------------------
INSERT INTO TicketAttachments (TicketId, FileName, FileUrl, FileType, FileSizeKb, UploadedByUserId) VALUES
(1, 'gateway_logs_v2.txt', '/storage/attachments/gateway_logs_v2.txt', 'text/plain', 48, 4),
(1, 'error_screenshot.png', '/storage/attachments/error_screenshot.png', 'image/png', 212, 4);

-- ---------------------------------------------------------------------
-- Notifications
-- ---------------------------------------------------------------------
INSERT INTO Notifications (UserId, TicketId, Title, Message, NotificationType, IsRead) VALUES
(2, 1, 'New Critical Ticket Assigned', 'You have been assigned TCK-00001 (Critical).', 'TicketAssigned', 0),
(4, 1, 'Ticket Updated', 'Your ticket TCK-00001 has a new internal update.', 'StatusChanged', 1),
(6, 5, 'New Critical Ticket', 'TCK-00005 was created and marked Critical.', 'TicketCreated', 0);

-- ---------------------------------------------------------------------
-- ActivityLogs
-- ---------------------------------------------------------------------
INSERT INTO ActivityLogs (UserId, TicketId, ActionType, ActionDescription, OldValue, NewValue) VALUES
(4, 1, 'Created', 'Ticket created', NULL, NULL),
(2, 1, 'PriorityChanged', 'Priority changed', 'High', 'Critical'),
(3, 3, 'StatusChanged', 'Status changed to Resolved', 'In Progress', 'Resolved');

-- ---------------------------------------------------------------------
-- TicketAssignmentHistory
-- ---------------------------------------------------------------------
INSERT INTO TicketAssignmentHistory (TicketId, AssignedFromUserId, AssignedToUserId, AssignedByUserId, AssignmentType) VALUES
(1, NULL, 2, 1, 'Auto'),
(2, NULL, 3, 1, 'Manual');

-- ---------------------------------------------------------------------
-- KnowledgeBaseArticles
-- ---------------------------------------------------------------------
INSERT INTO KnowledgeBaseArticles (CategoryId, AuthorUserId, ApprovedByUserId, Title, Content, IsApproved, ViewCount) VALUES
(3, 1, 1, 'How to Connect to the Global VPN (NA-West)',
 'Covers installation and configuration of the AnyConnect client for macOS and Windows users, including server address and common connection issues.', 1, 12400),
(5, 1, 1, 'Enabling Multi-Factor Authentication (Okta)',
 'Step-by-step guide to enrolling in MFA via Okta Verify as required by company security policy.', 1, 8200);
