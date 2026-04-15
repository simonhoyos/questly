CREATE TYPE "role" AS ENUM ('ADMIN', 'TEACHER', 'STUDENT');
CREATE TYPE "operation" AS ENUM ('CREATE', 'UPDATE', 'DELETE');

CREATE TABLE "user" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),

    "email" TEXT NOT NULL,
    "role" "role" NOT NULL DEFAULT 'STUDENT',

    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "archived_at" TIMESTAMP(3),

    CONSTRAINT "user_pkey" PRIMARY KEY ("id")
);

CREATE TABLE "user_token" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),

    "token" TEXT NOT NULL,
    "data" JSONB NOT NULL,

    "user_id" UUID NOT NULL,

    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "archived_at" TIMESTAMP(3),

    CONSTRAINT "user_token_pkey" PRIMARY KEY ("id"),
    CONSTRAINT "user_token_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "user"("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE "questionaire" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),

    "secret" TEXT NOT NULL DEFAULT SUBSTRING(MD5(RANDOM()::TEXT) FROM 1 FOR 8),
    "start_date" TIMESTAMPTZ NOT NULL,
    "end_date" TIMESTAMPTZ NOT NULL,

    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "archived_at" TIMESTAMP(3),

    CONSTRAINT "questionaire_pkey" PRIMARY KEY ("id")
);

CREATE TABLE "question" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),

    "statement" TEXT NOT NULL,

    "questionaire_id" UUID NOT NULL,

    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "archived_at" TIMESTAMP(3),

    CONSTRAINT "question_pkey" PRIMARY KEY ("id"),
    CONSTRAINT "question_questionaire_id_fkey" FOREIGN KEY ("questionaire_id") REFERENCES "questionaire"("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE "answer" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),

    "text" TEXT NOT NULL,
    "is_correct" BOOL NOT NULL DEFAULT false,

    "question_id" UUID NOT NULL,

    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "archived_at" TIMESTAMP(3),

    CONSTRAINT "answer_pkey" PRIMARY KEY ("id"),
    CONSTRAINT "answer_question_id_fkey" FOREIGN KEY ("question_id") REFERENCES "question"("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE "user_questionaire" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),

    "questionaire_id" UUID NOT NULL,
    "user_token_id" UUID NOT NULL,

    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "archived_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "user_questionaire_pkey" PRIMARY KEY ("id"),
    CONSTRAINT "user_questionaire_user_token_id_fkey" FOREIGN KEY ("user_token_id") REFERENCES "user_token"("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "user_questionaire_questionaire_id_fkey" FOREIGN KEY ("questionaire_id") REFERENCES "questionaire"("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE "user_answer" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),

    "user_questionaire_id" UUID NOT NULL,
    "question_id" UUID NOT NULL,
    "answer_id" UUID NOT NULL,

    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "answered_at" TIMESTAMP(3),

    CONSTRAINT "user_answer_pkey" PRIMARY KEY ("id"),
    CONSTRAINT "user_answer_user_questionaire_id_fkey" FOREIGN KEY ("user_questionaire_id") REFERENCES "user_questionaire"("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "user_answer_question_id_fkey" FOREIGN KEY ("question_id") REFERENCES "question"("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "user_answer_answer_id_fkey" FOREIGN KEY ("answer_id") REFERENCES "answer"("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE "audit" (
    "id" UUID NOT NULL DEFAULT gen_random_uuid(),

    "user_id" UUID NOT NULL,

    "operation" "operation" NOT NULL,

    "object" TEXT NOT NULL,
    "object_id" UUID NOT NULL,

    "data" JSONB NOT NULL,

    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "audit_pkey" PRIMARY KEY ("id"),
    CONSTRAINT "audit_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "user"("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE UNIQUE INDEX "user_email_key" ON "user"("email");
