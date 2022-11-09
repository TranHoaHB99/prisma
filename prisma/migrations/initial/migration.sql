-- CreateTable
CREATE TABLE `audit_logs` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `reference_id` VARCHAR(50) NULL,
    `payload` LONGTEXT NULL,
    `action_name` VARCHAR(50) NULL,
    `module_name` VARCHAR(50) NULL,
    `actioned_by` VARCHAR(50) NOT NULL,
    `actioned_on` DATETIME(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `extracted_at` DATETIME(0) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `booking_channel` (
    `channel_id` VARCHAR(35) NOT NULL,
    `business_rules` VARCHAR(3000) NULL,
    `priority` INTEGER NOT NULL,
    `applicable_patterns` VARCHAR(4000) NULL,
    `excluded_patterns` VARCHAR(4000) NULL,

    PRIMARY KEY (`channel_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `business_rule` (
    `feature_code` VARCHAR(35) NOT NULL,
    `category` VARCHAR(60) NULL,
    `feature_name` VARCHAR(150) NULL,
    `enable_ssra` TINYINT NULL DEFAULT 0,

    UNIQUE INDEX `feature_code_UNIQUE`(`feature_code`),
    PRIMARY KEY (`feature_code`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `change_of_date` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `policy_id` VARCHAR(15) NOT NULL,
    `waiver_option_id` INTEGER NOT NULL,
    `travel_start_date` DATE NULL,
    `travel_end_date` DATE NULL,
    `rebooking_range` VARCHAR(10) NULL,
    `rebooking_fee_flag` BOOLEAN NOT NULL DEFAULT false,
    `rebook_flightno` VARCHAR(100) NULL,
    `force_sell_rbd_flag` BOOLEAN NOT NULL DEFAULT false,
    `oal_allowed_flag` BOOLEAN NOT NULL,
    `order_id` TINYINT NULL,
    `extracted_at` DATETIME(0) NULL,

    UNIQUE INDEX `id_UNIQUE`(`id`),
    INDEX `Policy_id_cod_idx`(`policy_id`),
    INDEX `waiver_id_cod_idx`(`waiver_option_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `config_master` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `option_type` VARCHAR(50) NULL,
    `option_value` VARCHAR(100) NULL,
    `conditional_flag` BOOLEAN NOT NULL DEFAULT false,
    `active_status` BOOLEAN NOT NULL DEFAULT false,
    `option_description` VARCHAR(100) NULL,
    `option_display_value` VARCHAR(255) NULL DEFAULT '',
    `priority` TINYINT NULL DEFAULT 1,

    UNIQUE INDEX `id_UNIQUE`(`id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `convert_open_ticket` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `policy_id` VARCHAR(15) NOT NULL,
    `waiver_option_id` INTEGER NOT NULL,
    `travel_start_date` DATE NULL,
    `travel_end_date` DATE NULL,
    `rebooking_fee_flag` BOOLEAN NOT NULL DEFAULT false,
    `order_id` TINYINT NULL,
    `extracted_at` DATETIME(0) NULL,

    UNIQUE INDEX `id_UNIQUE`(`id`),
    INDEX `policy_id_cot_idx`(`policy_id`),
    INDEX `waiver_id_cot_idx`(`waiver_option_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `feature_detail` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `feature_name` VARCHAR(100) NULL,
    `feature_description` VARCHAR(100) NULL,
    `module` VARCHAR(100) NULL,
    `status` BOOLEAN NULL,
    `created_by` VARCHAR(50) NULL,
    `updated_by` VARCHAR(50) NULL,
    `created_at` DATETIME(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updated_at` DATETIME(0) NULL,

    UNIQUE INDEX `id_UNIQUE`(`id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `impacted_filter` (
    `policy_id` VARCHAR(15) NULL,
    `origin` VARCHAR(10) NULL,
    `destination` VARCHAR(10) NULL,
    `flightno` VARCHAR(30) NULL,
    `travel_start_date` DATE NULL,
    `travel_end_date` DATE NULL,

    INDEX `policy_id`(`policy_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `impacted_flights` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `policy_id` VARCHAR(15) NOT NULL,
    `flightno` VARCHAR(20) NULL,
    `origin` VARCHAR(10) NULL,
    `destination` VARCHAR(10) NULL,
    `travel_date` DATE NULL,
    `extracted_at` DATETIME(0) NULL,

    UNIQUE INDEX `id_UNIQUE`(`id`),
    INDEX `policy_id_fk_idx`(`policy_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `impactedpnr_detail` (
    `policy_id` VARCHAR(15) NOT NULL,
    `record_locator` VARCHAR(10) NOT NULL,
    `origin` VARCHAR(20) NULL,
    `destination` VARCHAR(20) NULL,
    `travel_date` DATE NOT NULL,
    `flight_number` VARCHAR(45) NULL,
    `status` INTEGER NOT NULL DEFAULT 44,
    `error_code` VARCHAR(45) NULL,
    `error_description` VARCHAR(1000) NULL,
    `remarks` VARCHAR(500) NULL,
    `created_on` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `edited_on` TIMESTAMP(0) NULL,
    `try_count` INTEGER NULL DEFAULT 0,
    `is_sk_inserted` TINYINT NULL DEFAULT 0,
    `is_mis_inserted` TINYINT NULL DEFAULT 0,
    `is_rx_inserted` TINYINT NULL DEFAULT 0,
    `segment_tattoo` INTEGER NULL DEFAULT 0,
    `extracted_at` DATETIME(0) NULL
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `job_detail` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `job_type` VARCHAR(50) NOT NULL,
    `start_time` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `end_time` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `frequency` VARCHAR(50) NULL,
    `status` BOOLEAN NOT NULL DEFAULT true,
    `error_description` TEXT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `notification` (
    `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
    `policy_id` VARCHAR(15) NULL,
    `role_id` VARCHAR(15) NULL,
    `message_type` ENUM('PENDING', 'EXPIRING', 'REJECTED', 'JOB_FAILED', 'JOB_COMPLETED') NULL,
    `message_content` VARCHAR(100) NULL,
    `is_read` TINYINT NULL DEFAULT 0,
    `created_date` DATETIME(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `extracted_at` DATETIME(0) NULL,

    INDEX `policy_id`(`policy_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `policy_detail` (
    `policy_id` VARCHAR(15) NOT NULL,
    `name` VARCHAR(50) NOT NULL,
    `description` VARCHAR(1000) NOT NULL,
    `validity_start_date` DATE NOT NULL,
    `validity_end_date` DATE NOT NULL,
    `waiver_reason_id` INTEGER NULL,
    `waiver_description` VARCHAR(1000) NULL,
    `status` VARCHAR(5) NOT NULL,
    `is_1click` TINYINT NULL DEFAULT 0,
    `is_archived` BOOLEAN NULL DEFAULT false,
    `issuance_start_date` DATE NULL,
    `issuance_end_date` DATE NULL,
    `cabin_class` VARCHAR(50) NULL,
    `kf_membership` VARCHAR(50) NULL,
    `created_on` DATETIME(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `approved_on` TIMESTAMP(0) NULL,
    `edited_on` TIMESTAMP(0) NULL,
    `total_impacted_pnr` INTEGER NULL DEFAULT 0,
    `is_all_pnr_queued` TINYINT NULL DEFAULT 0,
    `total_processed_pnr` INTEGER NULL DEFAULT 0,
    `total_failed_pnr` INTEGER NULL DEFAULT 0,
    `created_by` INTEGER NULL,
    `approved_by` INTEGER NULL,
    `edited_by` INTEGER NULL,
    `extracted_at` DATETIME(0) NULL,

    UNIQUE INDEX `policyautoid_UNIQUE`(`policy_id`),
    INDEX `fk_approved_by`(`approved_by`),
    INDEX `fk_created_by`(`created_by`),
    INDEX `fk_edited_by`(`edited_by`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `refund` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `policy_id` VARCHAR(15) NOT NULL,
    `waiver_option_id` INTEGER NOT NULL,
    `order_id` TINYINT NULL,
    `extracted_at` DATETIME(0) NULL,

    UNIQUE INDEX `id_UNIQUE`(`id`),
    INDEX `policy_id_ref_idx`(`policy_id`),
    INDEX `waiver_option_ref_idx`(`waiver_option_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `role_feature_mapping` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `role_id` INTEGER NULL,
    `feature_id` INTEGER NULL,
    `status` BOOLEAN NULL,

    UNIQUE INDEX `id_UNIQUE`(`id`),
    INDEX `fk_feature_idx`(`feature_id`),
    INDEX `fk_role_rfm_idx`(`role_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `user_access` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `user_id` VARCHAR(50) NOT NULL,
    `created_at` DATETIME(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updated_at` DATETIME(0) NULL,
    `created_by` INTEGER NULL,
    `updated_by` INTEGER NULL,
    `status` BOOLEAN NULL DEFAULT true,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `user_role_details` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `role_name` VARCHAR(80) NULL,
    `role_description` VARCHAR(100) NULL,
    `status` BOOLEAN NULL,
    `created_by` VARCHAR(50) NULL,
    `updated_by` VARCHAR(50) NULL,
    `created_at` DATETIME(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updated_at` DATETIME(0) NULL,

    UNIQUE INDEX `id_UNIQUE`(`id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `user_role_mapping` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `user_id` INTEGER NULL,
    `role_id` INTEGER NULL,

    UNIQUE INDEX `id_UNIQUE`(`id`),
    INDEX `fk_role_detail`(`role_id`),
    INDEX `fk_user`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `change_of_date` ADD CONSTRAINT `Policy_id_cod` FOREIGN KEY (`policy_id`) REFERENCES `policy_detail`(`policy_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `convert_open_ticket` ADD CONSTRAINT `policy_id_cot` FOREIGN KEY (`policy_id`) REFERENCES `policy_detail`(`policy_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `impacted_filter` ADD CONSTRAINT `impacted_filter_ibfk_1` FOREIGN KEY (`policy_id`) REFERENCES `policy_detail`(`policy_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `impacted_flights` ADD CONSTRAINT `policy_id_fk` FOREIGN KEY (`policy_id`) REFERENCES `policy_detail`(`policy_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `notification` ADD CONSTRAINT `notification_ibfk_1` FOREIGN KEY (`policy_id`) REFERENCES `policy_detail`(`policy_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `policy_detail` ADD CONSTRAINT `fk_approved_by` FOREIGN KEY (`approved_by`) REFERENCES `user_access`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `policy_detail` ADD CONSTRAINT `fk_created_by` FOREIGN KEY (`created_by`) REFERENCES `user_access`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `policy_detail` ADD CONSTRAINT `fk_edited_by` FOREIGN KEY (`edited_by`) REFERENCES `user_access`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `refund` ADD CONSTRAINT `policy_id_ref` FOREIGN KEY (`policy_id`) REFERENCES `policy_detail`(`policy_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `role_feature_mapping` ADD CONSTRAINT `fk_feature` FOREIGN KEY (`feature_id`) REFERENCES `feature_detail`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `role_feature_mapping` ADD CONSTRAINT `fk_role_rfm` FOREIGN KEY (`role_id`) REFERENCES `user_role_details`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `user_role_mapping` ADD CONSTRAINT `fk_role_detail` FOREIGN KEY (`role_id`) REFERENCES `user_role_details`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE `user_role_mapping` ADD CONSTRAINT `fk_user` FOREIGN KEY (`user_id`) REFERENCES `user_access`(`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
