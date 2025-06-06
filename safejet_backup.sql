PGDMP                      }            safejet_exchange    17.2    17.2 �    �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                           false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                           false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                           false            �           1262    16548    safejet_exchange    DATABASE     �   CREATE DATABASE safejet_exchange WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_United States.1252';
     DROP DATABASE safejet_exchange;
                     postgres    false            �           0    0    safejet_exchange    DATABASE PROPERTIES     =   ALTER DATABASE safejet_exchange SET search_path TO 'public';
                          postgres    false                        2615    17190    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
                     postgres    false            �           0    0    SCHEMA public    ACL     Q   REVOKE USAGE ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO PUBLIC;
                        postgres    false    6            �           1247    50657    deposits_status_enum    TYPE     t   CREATE TYPE public.deposits_status_enum AS ENUM (
    'pending',
    'confirming',
    'confirmed',
    'failed'
);
 '   DROP TYPE public.deposits_status_enum;
       public               postgres    false    6            �           1247    92592    news_and_updates_priority_enum    TYPE     c   CREATE TYPE public.news_and_updates_priority_enum AS ENUM (
    'high',
    'medium',
    'low'
);
 1   DROP TYPE public.news_and_updates_priority_enum;
       public               postgres    false    6            �           1247    92585    news_and_updates_type_enum    TYPE     o   CREATE TYPE public.news_and_updates_type_enum AS ENUM (
    'announcement',
    'marketUpdate',
    'alert'
);
 -   DROP TYPE public.news_and_updates_type_enum;
       public               postgres    false    6            �           1247    92328 "   p2p_chat_messages_messagetype_enum    TYPE     k   CREATE TYPE public.p2p_chat_messages_messagetype_enum AS ENUM (
    'BUYER',
    'SELLER',
    'SYSTEM'
);
 5   DROP TYPE public.p2p_chat_messages_messagetype_enum;
       public               postgres    false    6            �           1247    84020    p2p_orders_buyerstatus_enum    TYPE     �   CREATE TYPE public.p2p_orders_buyerstatus_enum AS ENUM (
    'pending',
    'paid',
    'disputed',
    'completed',
    'cancelled'
);
 .   DROP TYPE public.p2p_orders_buyerstatus_enum;
       public               postgres    false    6            �           1247    84032    p2p_orders_sellerstatus_enum    TYPE     �   CREATE TYPE public.p2p_orders_sellerstatus_enum AS ENUM (
    'pending',
    'confirmed',
    'disputed',
    'completed',
    'cancelled'
);
 /   DROP TYPE public.p2p_orders_sellerstatus_enum;
       public               postgres    false    6            �           1247    75426    sweep_transactions_status_enum    TYPE     {   CREATE TYPE public.sweep_transactions_status_enum AS ENUM (
    'pending',
    'completed',
    'failed',
    'skipped'
);
 1   DROP TYPE public.sweep_transactions_status_enum;
       public               postgres    false    6            �            1255    75344 !   check_wallet_key_user_reference()    FUNCTION     �  CREATE FUNCTION public.check_wallet_key_user_reference() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
            BEGIN
                IF NEW."userType" = 'user' THEN
                    IF NOT EXISTS (SELECT 1 FROM users WHERE id = NEW."userId") THEN
                        RAISE EXCEPTION 'User ID not found in users table';
                    END IF;
                ELSIF NEW."userType" = 'admin' THEN
                    IF NOT EXISTS (SELECT 1 FROM admins WHERE id = NEW."userId") THEN
                        RAISE EXCEPTION 'Admin ID not found in admins table';
                    END IF;
                END IF;
                RETURN NEW;
            END;
            $$;
 8   DROP FUNCTION public.check_wallet_key_user_reference();
       public               postgres    false    6            �            1259    75607    address_book    TABLE       CREATE TABLE public.address_book (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "userId" uuid NOT NULL,
    name character varying NOT NULL,
    address character varying NOT NULL,
    blockchain character varying NOT NULL,
    network character varying NOT NULL,
    memo character varying,
    tag character varying,
    "isActive" boolean DEFAULT true NOT NULL,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp without time zone DEFAULT now() NOT NULL
);
     DROP TABLE public.address_book;
       public         heap r       postgres    false    6    6    6            �            1259    75309    admin_wallets    TABLE     �  CREATE TABLE public.admin_wallets (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    blockchain character varying NOT NULL,
    network character varying NOT NULL,
    address character varying NOT NULL,
    "keyId" uuid NOT NULL,
    type character varying NOT NULL,
    "isActive" boolean DEFAULT true NOT NULL,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp without time zone DEFAULT now() NOT NULL
);
 !   DROP TABLE public.admin_wallets;
       public         heap r       postgres    false    6    6    6            �            1259    42408    admins    TABLE     j  CREATE TABLE public.admins (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    email character varying NOT NULL,
    password character varying NOT NULL,
    "isActive" boolean DEFAULT true,
    permissions jsonb,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp without time zone DEFAULT now() NOT NULL
);
    DROP TABLE public.admins;
       public         heap r       postgres    false    6    6    6            �            1259    75669    conversions    TABLE     _  CREATE TABLE public.conversions (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "userId" uuid NOT NULL,
    "fromTokenId" uuid NOT NULL,
    "toTokenId" uuid NOT NULL,
    "fromAmount" numeric(40,18) NOT NULL,
    "toAmount" numeric(40,18) NOT NULL,
    "exchangeRate" numeric(40,18) NOT NULL,
    "feeAmount" numeric(40,18) NOT NULL,
    "feeType" character varying NOT NULL,
    status character varying DEFAULT 'completed'::character varying NOT NULL,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp without time zone DEFAULT now() NOT NULL
);
    DROP TABLE public.conversions;
       public         heap r       postgres    false    6    6    6            �            1259    42039 
   currencies    TABLE     �  CREATE TABLE public.currencies (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    code character varying NOT NULL,
    name character varying NOT NULL,
    symbol character varying NOT NULL,
    "isActive" boolean DEFAULT true NOT NULL,
    "createdAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);
    DROP TABLE public.currencies;
       public         heap r       postgres    false    6    6    6            �            1259    50665    deposits    TABLE     �  CREATE TABLE public.deposits (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "userId" uuid NOT NULL,
    "walletId" uuid NOT NULL,
    "tokenId" uuid NOT NULL,
    "txHash" character varying NOT NULL,
    amount numeric(36,18) NOT NULL,
    blockchain character varying NOT NULL,
    network character varying NOT NULL,
    "networkVersion" character varying NOT NULL,
    "blockNumber" integer,
    confirmations integer DEFAULT 0 NOT NULL,
    status public.deposits_status_enum DEFAULT 'pending'::public.deposits_status_enum NOT NULL,
    metadata jsonb,
    "createdAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);
    DROP TABLE public.deposits;
       public         heap r       postgres    false    6    6    931    931    6            �            1259    42293    exchange_rates    TABLE       CREATE TABLE public.exchange_rates (
    id integer NOT NULL,
    currency character varying NOT NULL,
    rate numeric(18,8) NOT NULL,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL,
    "lastUpdated" timestamp without time zone DEFAULT now() NOT NULL
);
 "   DROP TABLE public.exchange_rates;
       public         heap r       postgres    false    6            �            1259    42292    exchange_rates_id_seq    SEQUENCE     �   CREATE SEQUENCE public.exchange_rates_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.exchange_rates_id_seq;
       public               postgres    false    6    232            �           0    0    exchange_rates_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.exchange_rates_id_seq OWNED BY public.exchange_rates.id;
          public               postgres    false    231            �            1259    75395    gas_tank_wallets    TABLE     �  CREATE TABLE public.gas_tank_wallets (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    blockchain character varying NOT NULL,
    network character varying NOT NULL,
    address character varying NOT NULL,
    "keyId" uuid NOT NULL,
    type character varying NOT NULL,
    "isActive" boolean DEFAULT true NOT NULL,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp without time zone DEFAULT now() NOT NULL
);
 $   DROP TABLE public.gas_tank_wallets;
       public         heap r       postgres    false    6    6    6            �            1259    17231 
   kyc_levels    TABLE     �  CREATE TABLE public.kyc_levels (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    level integer NOT NULL,
    title character varying NOT NULL,
    requirements text[] NOT NULL,
    benefits text[] NOT NULL,
    limits jsonb NOT NULL,
    features jsonb NOT NULL,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp without time zone DEFAULT now() NOT NULL
);
    DROP TABLE public.kyc_levels;
       public         heap r       postgres    false    6    6    6            �            1259    17203 
   migrations    TABLE     �   CREATE TABLE public.migrations (
    id integer NOT NULL,
    "timestamp" bigint NOT NULL,
    name character varying NOT NULL
);
    DROP TABLE public.migrations;
       public         heap r       postgres    false    6            �            1259    17202    migrations_id_seq    SEQUENCE     �   CREATE SEQUENCE public.migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.migrations_id_seq;
       public               postgres    false    6    219            �           0    0    migrations_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.migrations_id_seq OWNED BY public.migrations.id;
          public               postgres    false    218            �            1259    92599    news_and_updates    TABLE     v  CREATE TABLE public.news_and_updates (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    type public.news_and_updates_type_enum NOT NULL,
    priority public.news_and_updates_priority_enum NOT NULL,
    title character varying NOT NULL,
    "shortDescription" character varying(255) NOT NULL,
    content text NOT NULL,
    "isActive" boolean DEFAULT true NOT NULL,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp without time zone DEFAULT now() NOT NULL,
    "createdBy" uuid,
    "updatedBy" uuid,
    "imageUrl" character varying,
    "externalLink" character varying
);
 $   DROP TABLE public.news_and_updates;
       public         heap r       postgres    false    6    6    6    988    991            �            1259    92335    p2p_chat_messages    TABLE     C  CREATE TABLE public.p2p_chat_messages (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "orderId" uuid NOT NULL,
    "senderId" uuid,
    "messageType" public.p2p_chat_messages_messagetype_enum NOT NULL,
    message text NOT NULL,
    "isDelivered" boolean DEFAULT false NOT NULL,
    "isRead" boolean DEFAULT false NOT NULL,
    "createdAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "attachmentUrl" character varying,
    "attachmentType" character varying
);
 %   DROP TABLE public.p2p_chat_messages;
       public         heap r       postgres    false    6    6    6    976            �            1259    92424    p2p_dispute_messages    TABLE     �  CREATE TABLE public.p2p_dispute_messages (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "disputeId" uuid NOT NULL,
    "senderId" uuid,
    "senderType" character varying DEFAULT 'user'::character varying NOT NULL,
    message text NOT NULL,
    "attachmentUrl" character varying,
    "attachmentType" character varying,
    "isDelivered" boolean DEFAULT false NOT NULL,
    "isRead" boolean DEFAULT false NOT NULL,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL
);
 (   DROP TABLE public.p2p_dispute_messages;
       public         heap r       postgres    false    6    6    6            �            1259    92392    p2p_disputes    TABLE     �  CREATE TABLE public.p2p_disputes (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "orderId" uuid NOT NULL,
    "initiatorId" uuid NOT NULL,
    "respondentId" uuid,
    reason text NOT NULL,
    "reasonType" character varying DEFAULT 'other'::character varying NOT NULL,
    status character varying DEFAULT 'pending'::character varying NOT NULL,
    evidence jsonb,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp without time zone DEFAULT now() NOT NULL,
    "resolvedAt" timestamp without time zone,
    "adminId" uuid,
    "adminNotes" text,
    "progressHistory" jsonb DEFAULT '[]'::jsonb
);
     DROP TABLE public.p2p_disputes;
       public         heap r       postgres    false    6    6    6            �           0    0 %   COLUMN p2p_disputes."progressHistory"    COMMENT     �   COMMENT ON COLUMN public.p2p_disputes."progressHistory" IS 'Array of progress steps with structure: [{title: string, details: string, timestamp: string, addedBy: string}]';
          public               postgres    false    246            �            1259    75712 
   p2p_offers    TABLE       CREATE TABLE public.p2p_offers (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "userId" uuid NOT NULL,
    type character varying NOT NULL,
    "tokenId" uuid NOT NULL,
    amount numeric(40,18) NOT NULL,
    currency character varying NOT NULL,
    price numeric(40,18) NOT NULL,
    "priceUSD" numeric(40,18) NOT NULL,
    "paymentMethods" jsonb NOT NULL,
    terms text NOT NULL,
    status character varying NOT NULL,
    "createdAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    metadata jsonb DEFAULT '{}'::jsonb,
    "priceType" character varying(20) DEFAULT 'fixed'::character varying NOT NULL,
    "priceDelta" numeric(36,18) DEFAULT '0'::numeric NOT NULL
);
    DROP TABLE public.p2p_offers;
       public         heap r       postgres    false    6    6    6            �            1259    84043 
   p2p_orders    TABLE       CREATE TABLE public.p2p_orders (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "offerId" uuid NOT NULL,
    "buyerId" uuid NOT NULL,
    "sellerId" uuid NOT NULL,
    "paymentMetadata" jsonb NOT NULL,
    "assetAmount" numeric(24,8) NOT NULL,
    "currencyAmount" numeric(24,8) NOT NULL,
    "buyerStatus" public.p2p_orders_buyerstatus_enum DEFAULT 'pending'::public.p2p_orders_buyerstatus_enum NOT NULL,
    "sellerStatus" public.p2p_orders_sellerstatus_enum DEFAULT 'pending'::public.p2p_orders_sellerstatus_enum NOT NULL,
    "trackingId" character varying NOT NULL,
    "createdAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "paidAt" timestamp without time zone,
    "confirmedAt" timestamp without time zone,
    "completedAt" timestamp without time zone,
    "updatedAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "paymentDeadline" timestamp without time zone,
    "confirmationDeadline" timestamp without time zone,
    price numeric(24,8),
    "cancellationMetadata" jsonb
);
    DROP TABLE public.p2p_orders;
       public         heap r       postgres    false    6    6    967    970    6    970    967            �           0    0 (   COLUMN p2p_orders."cancellationMetadata"    COMMENT     �   COMMENT ON COLUMN public.p2p_orders."cancellationMetadata" IS 'JSON object with structure: {cancelledBy: "buyer"|"seller", reason: string, additionalDetails: string}';
          public               postgres    false    244            �            1259    42016    p2p_trader_settings    TABLE     �  CREATE TABLE public.p2p_trader_settings (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "userId" uuid NOT NULL,
    currency character varying DEFAULT 'NGN'::character varying NOT NULL,
    "autoAcceptOrders" boolean DEFAULT false NOT NULL,
    "onlyVerifiedUsers" boolean DEFAULT true NOT NULL,
    "showOnlineStatus" boolean DEFAULT true NOT NULL,
    "enableInstantTrade" boolean DEFAULT false NOT NULL,
    timezone character varying DEFAULT 'Africa/Lagos'::character varying NOT NULL,
    "createdAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    auto_responses jsonb DEFAULT '[{"id": "1", "icon": "payment", "type": "Payment", "color": "#4CAF50", "message": "I have made the payment, please check."}, {"id": "2", "icon": "request_page", "type": "Request", "color": "#2196F3", "message": "Please provide your payment details."}, {"id": "3", "icon": "check_circle", "type": "Confirmation", "color": "#9C27B0", "message": "Payment received, releasing crypto now."}, {"id": "4", "icon": "favorite", "type": "Thanks", "color": "#E91E63", "message": "Thank you for trading with me!"}]'::jsonb
);
 '   DROP TABLE public.p2p_trader_settings;
       public         heap r       postgres    false    6    6    6            �            1259    33775    payment_method_fields    TABLE     L  CREATE TABLE public.payment_method_fields (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "paymentMethodTypeId" uuid NOT NULL,
    name character varying NOT NULL,
    label character varying NOT NULL,
    type character varying NOT NULL,
    placeholder character varying,
    "helpText" text,
    "validationRules" jsonb,
    "isRequired" boolean DEFAULT true NOT NULL,
    "order" integer DEFAULT 0 NOT NULL,
    "createdAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);
 )   DROP TABLE public.payment_method_fields;
       public         heap r       postgres    false    6    6    6            �            1259    33764    payment_method_types    TABLE     �  CREATE TABLE public.payment_method_types (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    name character varying NOT NULL,
    icon character varying NOT NULL,
    description text NOT NULL,
    "isActive" boolean DEFAULT true NOT NULL,
    "createdAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);
 (   DROP TABLE public.payment_method_types;
       public         heap r       postgres    false    6    6    6            �            1259    33752    payment_methods    TABLE        CREATE TABLE public.payment_methods (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "userId" uuid NOT NULL,
    "paymentMethodTypeId" uuid NOT NULL,
    "isDefault" boolean DEFAULT false NOT NULL,
    "isVerified" boolean DEFAULT false NOT NULL,
    details jsonb NOT NULL,
    "createdAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    name character varying(100) DEFAULT 'Unnamed Payment Method'::character varying NOT NULL
);
 #   DROP TABLE public.payment_methods;
       public         heap r       postgres    false    6    6    6            �            1259    92649    platform_settings    TABLE     �  CREATE TABLE public.platform_settings (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    key character varying(255) NOT NULL,
    value jsonb NOT NULL,
    description text,
    category character varying(50) DEFAULT 'general'::character varying NOT NULL,
    "isSensitive" boolean DEFAULT false NOT NULL,
    "lastUpdatedBy" uuid,
    "createdAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);
 %   DROP TABLE public.platform_settings;
       public         heap r       postgres    false    6    6    6            �            1259    75349    sweep_transactions    TABLE       CREATE TABLE public.sweep_transactions (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "depositId" uuid NOT NULL,
    "fromWalletId" uuid NOT NULL,
    "toAdminWalletId" uuid NOT NULL,
    "txHash" character varying NOT NULL,
    amount character varying NOT NULL,
    status public.sweep_transactions_status_enum NOT NULL,
    metadata jsonb,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp without time zone DEFAULT now() NOT NULL,
    message text
);
 &   DROP TABLE public.sweep_transactions;
       public         heap r       postgres    false    6    6    6    949            �            1259    50680    system_settings    TABLE       CREATE TABLE public.system_settings (
    key character varying NOT NULL,
    value character varying NOT NULL,
    "createdAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);
 #   DROP TABLE public.system_settings;
       public         heap r       postgres    false    6            �            1259    42261    tokens    TABLE       CREATE TABLE public.tokens (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    symbol character varying NOT NULL,
    name character varying NOT NULL,
    blockchain character varying NOT NULL,
    "contractAddress" character varying,
    decimals integer NOT NULL,
    "isActive" boolean DEFAULT true NOT NULL,
    metadata jsonb,
    "lastPriceUpdate" timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "baseSymbol" character varying,
    "networkVersion" character varying,
    "currentPrice" numeric(40,18) DEFAULT 0,
    price24h numeric(40,18) DEFAULT 0,
    "changePercent24h" numeric(40,18) DEFAULT 0,
    "coingeckoId" character varying,
    "marketCap" numeric(40,18),
    "fullyDilutedMarketCap" numeric(40,18),
    volume24h numeric(40,18),
    "circulatingSupply" numeric(40,18),
    "maxSupply" numeric(40,18),
    "marketCapChange24h" numeric(40,18),
    "marketCapChangePercent24h" numeric(40,18),
    "volumeChangePercent24h" numeric(40,18),
    "priceHistory" jsonb,
    "networkConfigs" jsonb
);
    DROP TABLE public.tokens;
       public         heap r       postgres    false    6    6    6            �            1259    75635 	   transfers    TABLE     �  CREATE TABLE public.transfers (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "userId" uuid NOT NULL,
    "tokenId" uuid NOT NULL,
    amount numeric(36,18) NOT NULL,
    "fromType" character varying NOT NULL,
    "toType" character varying NOT NULL,
    status character varying DEFAULT 'completed'::character varying NOT NULL,
    metadata jsonb,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp without time zone DEFAULT now() NOT NULL
);
    DROP TABLE public.transfers;
       public         heap r       postgres    false    6    6    6            �            1259    17211    users    TABLE     s  CREATE TABLE public.users (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    email character varying NOT NULL,
    phone character varying NOT NULL,
    "passwordHash" character varying NOT NULL,
    "emailVerified" boolean DEFAULT false NOT NULL,
    "phoneVerified" boolean DEFAULT false NOT NULL,
    "verificationLevel" integer DEFAULT 0 NOT NULL,
    "verificationCode" character varying,
    "verificationCodeExpires" timestamp without time zone,
    "passwordResetCode" character varying,
    "passwordResetExpires" timestamp without time zone,
    "twoFactorSecret" character varying,
    "twoFactorEnabled" boolean DEFAULT false NOT NULL,
    "twoFactorBackupCodes" character varying,
    "fullName" character varying NOT NULL,
    "countryCode" character varying NOT NULL,
    "countryName" character varying NOT NULL,
    "phoneWithoutCode" character varying NOT NULL,
    currency character varying DEFAULT 'USD'::character varying NOT NULL,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp without time zone DEFAULT now() NOT NULL,
    "kycLevel" integer DEFAULT 0 NOT NULL,
    "kycLevelId" uuid,
    "kycData" jsonb,
    "onfidoApplicantId" character varying,
    notification_settings jsonb DEFAULT '{"P2P": {"New Messages": true, "Order Status": true, "Dispute Updates": true, "Payment Confirmations": true}, "Wallet": {"Deposits": true, "Withdrawals": true, "Balance Updates": true, "Transfer Confirmations": false}, "Trading": {"Price Alerts": true, "Order Updates": true, "Market Updates": false, "Trade Confirmations": true}, "Security": {"Login Alerts": true, "Device Changes": true, "Password Changes": true, "Suspicious Activity": true}}'::jsonb NOT NULL,
    language character varying(10) DEFAULT 'en'::character varying NOT NULL,
    "biometricEnabled" boolean DEFAULT false,
    "isActive" boolean DEFAULT true NOT NULL
);
    DROP TABLE public.users;
       public         heap r       postgres    false    6    6    6            �            1259    42270    wallet_balances    TABLE     �  CREATE TABLE public.wallet_balances (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    balance numeric(36,18) DEFAULT 0 NOT NULL,
    type character varying NOT NULL,
    metadata jsonb,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp without time zone DEFAULT now() NOT NULL,
    "userId" uuid NOT NULL,
    "baseSymbol" character varying NOT NULL,
    frozen numeric(36,18) DEFAULT '0'::numeric NOT NULL
);
 #   DROP TABLE public.wallet_balances;
       public         heap r       postgres    false    6    6    6            �            1259    42220    wallet_keys    TABLE       CREATE TABLE public.wallet_keys (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "userId" uuid NOT NULL,
    "encryptedPrivateKey" text NOT NULL,
    "encryptionVersion" integer NOT NULL,
    "keyType" character varying DEFAULT 'hot'::character varying NOT NULL,
    "backupData" jsonb,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp without time zone DEFAULT now() NOT NULL,
    "userType" character varying DEFAULT 'user'::character varying NOT NULL
);
    DROP TABLE public.wallet_keys;
       public         heap r       postgres    false    6    6    6            �            1259    42236    wallets    TABLE     M  CREATE TABLE public.wallets (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "userId" uuid NOT NULL,
    blockchain character varying NOT NULL,
    network character varying DEFAULT 'mainnet'::character varying NOT NULL,
    address character varying NOT NULL,
    "keyId" uuid NOT NULL,
    status character varying DEFAULT 'active'::character varying NOT NULL,
    metadata jsonb,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp without time zone DEFAULT now() NOT NULL,
    memo character varying,
    tag character varying
);
    DROP TABLE public.wallets;
       public         heap r       postgres    false    6    6    6            �            1259    75506    withdrawals    TABLE     �  CREATE TABLE public.withdrawals (
    id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    "userId" uuid NOT NULL,
    "tokenId" uuid NOT NULL,
    address character varying NOT NULL,
    amount numeric(36,18) NOT NULL,
    fee numeric(36,18) NOT NULL,
    "networkVersion" character varying NOT NULL,
    network character varying NOT NULL,
    memo character varying,
    tag character varying,
    status character varying DEFAULT 'pending'::character varying NOT NULL,
    metadata jsonb,
    "createdAt" timestamp without time zone DEFAULT now() NOT NULL,
    "updatedAt" timestamp without time zone DEFAULT now() NOT NULL,
    "txHash" character varying
);
    DROP TABLE public.withdrawals;
       public         heap r       postgres    false    6    6    6            0           2604    42296    exchange_rates id    DEFAULT     v   ALTER TABLE ONLY public.exchange_rates ALTER COLUMN id SET DEFAULT nextval('public.exchange_rates_id_seq'::regclass);
 @   ALTER TABLE public.exchange_rates ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    231    232    232            �           2604    17206    migrations id    DEFAULT     n   ALTER TABLE ONLY public.migrations ALTER COLUMN id SET DEFAULT nextval('public.migrations_id_seq'::regclass);
 <   ALTER TABLE public.migrations ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    219    218    219            �          0    75607    address_book 
   TABLE DATA                 public               postgres    false    240   �(      �          0    75309    admin_wallets 
   TABLE DATA                 public               postgres    false    236   +      �          0    42408    admins 
   TABLE DATA                 public               postgres    false    233   /      �          0    75669    conversions 
   TABLE DATA                 public               postgres    false    242   ?0      �          0    42039 
   currencies 
   TABLE DATA                 public               postgres    false    226   �4      �          0    50665    deposits 
   TABLE DATA                 public               postgres    false    234   >6      �          0    42293    exchange_rates 
   TABLE DATA                 public               postgres    false    232   O      �          0    75395    gas_tank_wallets 
   TABLE DATA                 public               postgres    false    238   &P      �          0    17231 
   kyc_levels 
   TABLE DATA                 public               postgres    false    221   /T      �          0    17203 
   migrations 
   TABLE DATA                 public               postgres    false    219   W      �          0    92599    news_and_updates 
   TABLE DATA                 public               postgres    false    248   e[      �          0    92335    p2p_chat_messages 
   TABLE DATA                 public               postgres    false    245   �d      �          0    92424    p2p_dispute_messages 
   TABLE DATA                 public               postgres    false    247   �r      �          0    92392    p2p_disputes 
   TABLE DATA                 public               postgres    false    246   -}      �          0    75712 
   p2p_offers 
   TABLE DATA                 public               postgres    false    243   S�      �          0    84043 
   p2p_orders 
   TABLE DATA                 public               postgres    false    244   z�      �          0    42016    p2p_trader_settings 
   TABLE DATA                 public               postgres    false    225   ;�      �          0    33775    payment_method_fields 
   TABLE DATA                 public               postgres    false    224   ��      �          0    33764    payment_method_types 
   TABLE DATA                 public               postgres    false    223   W�      �          0    33752    payment_methods 
   TABLE DATA                 public               postgres    false    222   �      �          0    92649    platform_settings 
   TABLE DATA                 public               postgres    false    249   �      �          0    75349    sweep_transactions 
   TABLE DATA                 public               postgres    false    237   `�      �          0    50680    system_settings 
   TABLE DATA                 public               postgres    false    235   Z�      �          0    42261    tokens 
   TABLE DATA                 public               postgres    false    229   �      �          0    75635 	   transfers 
   TABLE DATA                 public               postgres    false    241   ��      �          0    17211    users 
   TABLE DATA                 public               postgres    false    220   ��      �          0    42270    wallet_balances 
   TABLE DATA                 public               postgres    false    230   8�      �          0    42220    wallet_keys 
   TABLE DATA                 public               postgres    false    227   }S      �          0    42236    wallets 
   TABLE DATA                 public               postgres    false    228   3|      �          0    75506    withdrawals 
   TABLE DATA                 public               postgres    false    239   ��      �           0    0    exchange_rates_id_seq    SEQUENCE SET     C   SELECT pg_catalog.setval('public.exchange_rates_id_seq', 4, true);
          public               postgres    false    231            �           0    0    migrations_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.migrations_id_seq', 69, true);
          public               postgres    false    218            �           2606    84054 )   p2p_orders PK_07e60e49b374f8ea622e9be7ca6 
   CONSTRAINT     i   ALTER TABLE ONLY public.p2p_orders
    ADD CONSTRAINT "PK_07e60e49b374f8ea622e9be7ca6" PRIMARY KEY (id);
 U   ALTER TABLE ONLY public.p2p_orders DROP CONSTRAINT "PK_07e60e49b374f8ea622e9be7ca6";
       public                 postgres    false    244            �           2606    75721 )   p2p_offers PK_0fadbc84c3ea0ba2c5e526a431c 
   CONSTRAINT     i   ALTER TABLE ONLY public.p2p_offers
    ADD CONSTRAINT "PK_0fadbc84c3ea0ba2c5e526a431c" PRIMARY KEY (id);
 U   ALTER TABLE ONLY public.p2p_offers DROP CONSTRAINT "PK_0fadbc84c3ea0ba2c5e526a431c";
       public                 postgres    false    243            �           2606    92660 0   platform_settings PK_2934aeb70ec285196dcab4a2e96 
   CONSTRAINT     p   ALTER TABLE ONLY public.platform_settings
    ADD CONSTRAINT "PK_2934aeb70ec285196dcab4a2e96" PRIMARY KEY (id);
 \   ALTER TABLE ONLY public.platform_settings DROP CONSTRAINT "PK_2934aeb70ec285196dcab4a2e96";
       public                 postgres    false    249            �           2606    42302 -   exchange_rates PK_33a614bad9e61956079d817ebe2 
   CONSTRAINT     m   ALTER TABLE ONLY public.exchange_rates
    ADD CONSTRAINT "PK_33a614bad9e61956079d817ebe2" PRIMARY KEY (id);
 Y   ALTER TABLE ONLY public.exchange_rates DROP CONSTRAINT "PK_33a614bad9e61956079d817ebe2";
       public                 postgres    false    232            �           2606    33763 .   payment_methods PK_34f9b8c6dfb4ac3559f7e2820d1 
   CONSTRAINT     n   ALTER TABLE ONLY public.payment_methods
    ADD CONSTRAINT "PK_34f9b8c6dfb4ac3559f7e2820d1" PRIMARY KEY (id);
 Z   ALTER TABLE ONLY public.payment_methods DROP CONSTRAINT "PK_34f9b8c6dfb4ac3559f7e2820d1";
       public                 postgres    false    222            �           2606    92609 /   news_and_updates PK_48e1380f74fa915148d4345f86c 
   CONSTRAINT     o   ALTER TABLE ONLY public.news_and_updates
    ADD CONSTRAINT "PK_48e1380f74fa915148d4345f86c" PRIMARY KEY (id);
 [   ALTER TABLE ONLY public.news_and_updates DROP CONSTRAINT "PK_48e1380f74fa915148d4345f86c";
       public                 postgres    false    248            �           2606    33774 3   payment_method_types PK_8a26a45c049347f51812830df04 
   CONSTRAINT     s   ALTER TABLE ONLY public.payment_method_types
    ADD CONSTRAINT "PK_8a26a45c049347f51812830df04" PRIMARY KEY (id);
 _   ALTER TABLE ONLY public.payment_method_types DROP CONSTRAINT "PK_8a26a45c049347f51812830df04";
       public                 postgres    false    223            ~           2606    17210 )   migrations PK_8c82d7f526340ab734260ea46be 
   CONSTRAINT     i   ALTER TABLE ONLY public.migrations
    ADD CONSTRAINT "PK_8c82d7f526340ab734260ea46be" PRIMARY KEY (id);
 U   ALTER TABLE ONLY public.migrations DROP CONSTRAINT "PK_8c82d7f526340ab734260ea46be";
       public                 postgres    false    219            �           2606    42031 2   p2p_trader_settings PK_9bc7bee5a12033c0e501c97481b 
   CONSTRAINT     r   ALTER TABLE ONLY public.p2p_trader_settings
    ADD CONSTRAINT "PK_9bc7bee5a12033c0e501c97481b" PRIMARY KEY (id);
 ^   ALTER TABLE ONLY public.p2p_trader_settings DROP CONSTRAINT "PK_9bc7bee5a12033c0e501c97481b";
       public                 postgres    false    225            �           2606    75617    address_book PK_address_book 
   CONSTRAINT     \   ALTER TABLE ONLY public.address_book
    ADD CONSTRAINT "PK_address_book" PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.address_book DROP CONSTRAINT "PK_address_book";
       public                 postgres    false    240            �           2606    75319    admin_wallets PK_admin_wallets 
   CONSTRAINT     ^   ALTER TABLE ONLY public.admin_wallets
    ADD CONSTRAINT "PK_admin_wallets" PRIMARY KEY (id);
 J   ALTER TABLE ONLY public.admin_wallets DROP CONSTRAINT "PK_admin_wallets";
       public                 postgres    false    236            �           2606    50688 .   system_settings PK_b1b5bc664526d375c94ce9ad43d 
   CONSTRAINT     o   ALTER TABLE ONLY public.system_settings
    ADD CONSTRAINT "PK_b1b5bc664526d375c94ce9ad43d" PRIMARY KEY (key);
 Z   ALTER TABLE ONLY public.system_settings DROP CONSTRAINT "PK_b1b5bc664526d375c94ce9ad43d";
       public                 postgres    false    235            �           2606    92346 0   p2p_chat_messages PK_b7b2a44f97ddd0014e17beb593a 
   CONSTRAINT     p   ALTER TABLE ONLY public.p2p_chat_messages
    ADD CONSTRAINT "PK_b7b2a44f97ddd0014e17beb593a" PRIMARY KEY (id);
 \   ALTER TABLE ONLY public.p2p_chat_messages DROP CONSTRAINT "PK_b7b2a44f97ddd0014e17beb593a";
       public                 postgres    false    245            �           2606    75679    conversions PK_conversions 
   CONSTRAINT     Z   ALTER TABLE ONLY public.conversions
    ADD CONSTRAINT "PK_conversions" PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.conversions DROP CONSTRAINT "PK_conversions";
       public                 postgres    false    242            �           2606    42049 )   currencies PK_d528c54860c4182db13548e08c4 
   CONSTRAINT     i   ALTER TABLE ONLY public.currencies
    ADD CONSTRAINT "PK_d528c54860c4182db13548e08c4" PRIMARY KEY (id);
 U   ALTER TABLE ONLY public.currencies DROP CONSTRAINT "PK_d528c54860c4182db13548e08c4";
       public                 postgres    false    226            �           2606    33786 4   payment_method_fields PK_e7f159a6d9e49fbdbcca0b90585 
   CONSTRAINT     t   ALTER TABLE ONLY public.payment_method_fields
    ADD CONSTRAINT "PK_e7f159a6d9e49fbdbcca0b90585" PRIMARY KEY (id);
 `   ALTER TABLE ONLY public.payment_method_fields DROP CONSTRAINT "PK_e7f159a6d9e49fbdbcca0b90585";
       public                 postgres    false    224            �           2606    50676 '   deposits PK_f49ba0cd446eaf7abb4953385d9 
   CONSTRAINT     g   ALTER TABLE ONLY public.deposits
    ADD CONSTRAINT "PK_f49ba0cd446eaf7abb4953385d9" PRIMARY KEY (id);
 S   ALTER TABLE ONLY public.deposits DROP CONSTRAINT "PK_f49ba0cd446eaf7abb4953385d9";
       public                 postgres    false    234            �           2606    75405 $   gas_tank_wallets PK_gas_tank_wallets 
   CONSTRAINT     d   ALTER TABLE ONLY public.gas_tank_wallets
    ADD CONSTRAINT "PK_gas_tank_wallets" PRIMARY KEY (id);
 P   ALTER TABLE ONLY public.gas_tank_wallets DROP CONSTRAINT "PK_gas_tank_wallets";
       public                 postgres    false    238            �           2606    92435 ,   p2p_dispute_messages PK_p2p_dispute_messages 
   CONSTRAINT     l   ALTER TABLE ONLY public.p2p_dispute_messages
    ADD CONSTRAINT "PK_p2p_dispute_messages" PRIMARY KEY (id);
 X   ALTER TABLE ONLY public.p2p_dispute_messages DROP CONSTRAINT "PK_p2p_dispute_messages";
       public                 postgres    false    247            �           2606    92403    p2p_disputes PK_p2p_disputes 
   CONSTRAINT     \   ALTER TABLE ONLY public.p2p_disputes
    ADD CONSTRAINT "PK_p2p_disputes" PRIMARY KEY (id);
 H   ALTER TABLE ONLY public.p2p_disputes DROP CONSTRAINT "PK_p2p_disputes";
       public                 postgres    false    246            �           2606    75358 (   sweep_transactions PK_sweep_transactions 
   CONSTRAINT     h   ALTER TABLE ONLY public.sweep_transactions
    ADD CONSTRAINT "PK_sweep_transactions" PRIMARY KEY (id);
 T   ALTER TABLE ONLY public.sweep_transactions DROP CONSTRAINT "PK_sweep_transactions";
       public                 postgres    false    237            �           2606    75645    transfers PK_transfers 
   CONSTRAINT     V   ALTER TABLE ONLY public.transfers
    ADD CONSTRAINT "PK_transfers" PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.transfers DROP CONSTRAINT "PK_transfers";
       public                 postgres    false    241            �           2606    17226    users PK_users_id 
   CONSTRAINT     Q   ALTER TABLE ONLY public.users
    ADD CONSTRAINT "PK_users_id" PRIMARY KEY (id);
 =   ALTER TABLE ONLY public.users DROP CONSTRAINT "PK_users_id";
       public                 postgres    false    220            �           2606    75516    withdrawals PK_withdrawals 
   CONSTRAINT     Z   ALTER TABLE ONLY public.withdrawals
    ADD CONSTRAINT "PK_withdrawals" PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.withdrawals DROP CONSTRAINT "PK_withdrawals";
       public                 postgres    false    239            �           2606    42033 2   p2p_trader_settings UQ_2ea92e7c08d6b5950986f153d21 
   CONSTRAINT     s   ALTER TABLE ONLY public.p2p_trader_settings
    ADD CONSTRAINT "UQ_2ea92e7c08d6b5950986f153d21" UNIQUE ("userId");
 ^   ALTER TABLE ONLY public.p2p_trader_settings DROP CONSTRAINT "UQ_2ea92e7c08d6b5950986f153d21";
       public                 postgres    false    225            �           2606    92662 0   platform_settings UQ_5d9031e30fac3ec3ec8b9602e17 
   CONSTRAINT     l   ALTER TABLE ONLY public.platform_settings
    ADD CONSTRAINT "UQ_5d9031e30fac3ec3ec8b9602e17" UNIQUE (key);
 \   ALTER TABLE ONLY public.platform_settings DROP CONSTRAINT "UQ_5d9031e30fac3ec3ec8b9602e17";
       public                 postgres    false    249            �           2606    84056 )   p2p_orders UQ_90f1caa880f15c04b8091bf97c2 
   CONSTRAINT     n   ALTER TABLE ONLY public.p2p_orders
    ADD CONSTRAINT "UQ_90f1caa880f15c04b8091bf97c2" UNIQUE ("trackingId");
 U   ALTER TABLE ONLY public.p2p_orders DROP CONSTRAINT "UQ_90f1caa880f15c04b8091bf97c2";
       public                 postgres    false    244            �           2606    42051 )   currencies UQ_9f8d0972aeeb5a2277e40332d29 
   CONSTRAINT     f   ALTER TABLE ONLY public.currencies
    ADD CONSTRAINT "UQ_9f8d0972aeeb5a2277e40332d29" UNIQUE (code);
 U   ALTER TABLE ONLY public.currencies DROP CONSTRAINT "UQ_9f8d0972aeeb5a2277e40332d29";
       public                 postgres    false    226            �           2606    17228    users UQ_users_email 
   CONSTRAINT     R   ALTER TABLE ONLY public.users
    ADD CONSTRAINT "UQ_users_email" UNIQUE (email);
 @   ALTER TABLE ONLY public.users DROP CONSTRAINT "UQ_users_email";
       public                 postgres    false    220            �           2606    17230    users UQ_users_phone 
   CONSTRAINT     R   ALTER TABLE ONLY public.users
    ADD CONSTRAINT "UQ_users_phone" UNIQUE (phone);
 @   ALTER TABLE ONLY public.users DROP CONSTRAINT "UQ_users_phone";
       public                 postgres    false    220            �           2606    42420    admins admins_email_key 
   CONSTRAINT     S   ALTER TABLE ONLY public.admins
    ADD CONSTRAINT admins_email_key UNIQUE (email);
 A   ALTER TABLE ONLY public.admins DROP CONSTRAINT admins_email_key;
       public                 postgres    false    233            �           2606    42418    admins admins_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.admins
    ADD CONSTRAINT admins_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.admins DROP CONSTRAINT admins_pkey;
       public                 postgres    false    233            �           2606    17240    kyc_levels kyc_levels_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.kyc_levels
    ADD CONSTRAINT kyc_levels_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.kyc_levels DROP CONSTRAINT kyc_levels_pkey;
       public                 postgres    false    221            �           2606    42269    tokens tokens_pkey 
   CONSTRAINT     P   ALTER TABLE ONLY public.tokens
    ADD CONSTRAINT tokens_pkey PRIMARY KEY (id);
 <   ALTER TABLE ONLY public.tokens DROP CONSTRAINT tokens_pkey;
       public                 postgres    false    229            �           2606    42280 $   wallet_balances wallet_balances_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.wallet_balances
    ADD CONSTRAINT wallet_balances_pkey PRIMARY KEY (id);
 N   ALTER TABLE ONLY public.wallet_balances DROP CONSTRAINT wallet_balances_pkey;
       public                 postgres    false    230            �           2606    42230    wallet_keys wallet_keys_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.wallet_keys
    ADD CONSTRAINT wallet_keys_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.wallet_keys DROP CONSTRAINT wallet_keys_pkey;
       public                 postgres    false    227            �           2606    42247    wallets wallets_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.wallets
    ADD CONSTRAINT wallets_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.wallets DROP CONSTRAINT wallets_pkey;
       public                 postgres    false    228            �           1259    42303    IDX_EXCHANGE_RATES_CURRENCY    INDEX     \   CREATE INDEX "IDX_EXCHANGE_RATES_CURRENCY" ON public.exchange_rates USING btree (currency);
 1   DROP INDEX public."IDX_EXCHANGE_RATES_CURRENCY";
       public                 postgres    false    232            �           1259    92669    IDX_PLATFORM_SETTINGS_CATEGORY    INDEX     b   CREATE INDEX "IDX_PLATFORM_SETTINGS_CATEGORY" ON public.platform_settings USING btree (category);
 4   DROP INDEX public."IDX_PLATFORM_SETTINGS_CATEGORY";
       public                 postgres    false    249            �           1259    92668    IDX_PLATFORM_SETTINGS_KEY    INDEX     X   CREATE INDEX "IDX_PLATFORM_SETTINGS_KEY" ON public.platform_settings USING btree (key);
 /   DROP INDEX public."IDX_PLATFORM_SETTINGS_KEY";
       public                 postgres    false    249            �           1259    75329    IDX_WALLET_KEYS_USER_TYPE    INDEX     Y   CREATE INDEX "IDX_WALLET_KEYS_USER_TYPE" ON public.wallet_keys USING btree ("userType");
 /   DROP INDEX public."IDX_WALLET_KEYS_USER_TYPE";
       public                 postgres    false    227            �           1259    75623    IDX_address_book_user    INDEX     T   CREATE INDEX "IDX_address_book_user" ON public.address_book USING btree ("userId");
 +   DROP INDEX public."IDX_address_book_user";
       public                 postgres    false    240            �           1259    75325 $   IDX_admin_wallets_blockchain_network    INDEX     o   CREATE INDEX "IDX_admin_wallets_blockchain_network" ON public.admin_wallets USING btree (blockchain, network);
 :   DROP INDEX public."IDX_admin_wallets_blockchain_network";
       public                 postgres    false    236    236            �           1259    75696    IDX_conversions_tokens    INDEX     f   CREATE INDEX "IDX_conversions_tokens" ON public.conversions USING btree ("fromTokenId", "toTokenId");
 ,   DROP INDEX public."IDX_conversions_tokens";
       public                 postgres    false    242    242            �           1259    75695    IDX_conversions_user    INDEX     R   CREATE INDEX "IDX_conversions_user" ON public.conversions USING btree ("userId");
 *   DROP INDEX public."IDX_conversions_user";
       public                 postgres    false    242            �           1259    50678    IDX_deposits_status    INDEX     L   CREATE INDEX "IDX_deposits_status" ON public.deposits USING btree (status);
 )   DROP INDEX public."IDX_deposits_status";
       public                 postgres    false    234            �           1259    50679    IDX_deposits_txHash    INDEX     N   CREATE INDEX "IDX_deposits_txHash" ON public.deposits USING btree ("txHash");
 )   DROP INDEX public."IDX_deposits_txHash";
       public                 postgres    false    234            �           1259    50677    IDX_deposits_userId    INDEX     N   CREATE INDEX "IDX_deposits_userId" ON public.deposits USING btree ("userId");
 )   DROP INDEX public."IDX_deposits_userId";
       public                 postgres    false    234            �           1259    75411 '   IDX_gas_tank_wallets_blockchain_network    INDEX     u   CREATE INDEX "IDX_gas_tank_wallets_blockchain_network" ON public.gas_tank_wallets USING btree (blockchain, network);
 =   DROP INDEX public."IDX_gas_tank_wallets_blockchain_network";
       public                 postgres    false    238    238            �           1259    92359    IDX_p2p_chat_messages_created    INDEX     d   CREATE INDEX "IDX_p2p_chat_messages_created" ON public.p2p_chat_messages USING btree ("createdAt");
 3   DROP INDEX public."IDX_p2p_chat_messages_created";
       public                 postgres    false    245            �           1259    92357    IDX_p2p_chat_messages_order    INDEX     `   CREATE INDEX "IDX_p2p_chat_messages_order" ON public.p2p_chat_messages USING btree ("orderId");
 1   DROP INDEX public."IDX_p2p_chat_messages_order";
       public                 postgres    false    245            �           1259    92358    IDX_p2p_chat_messages_sender    INDEX     b   CREATE INDEX "IDX_p2p_chat_messages_sender" ON public.p2p_chat_messages USING btree ("senderId");
 2   DROP INDEX public."IDX_p2p_chat_messages_sender";
       public                 postgres    false    245            �           1259    92453     IDX_p2p_dispute_messages_created    INDEX     j   CREATE INDEX "IDX_p2p_dispute_messages_created" ON public.p2p_dispute_messages USING btree ("createdAt");
 6   DROP INDEX public."IDX_p2p_dispute_messages_created";
       public                 postgres    false    247            �           1259    92451     IDX_p2p_dispute_messages_dispute    INDEX     j   CREATE INDEX "IDX_p2p_dispute_messages_dispute" ON public.p2p_dispute_messages USING btree ("disputeId");
 6   DROP INDEX public."IDX_p2p_dispute_messages_dispute";
       public                 postgres    false    247            �           1259    92452    IDX_p2p_dispute_messages_sender    INDEX     h   CREATE INDEX "IDX_p2p_dispute_messages_sender" ON public.p2p_dispute_messages USING btree ("senderId");
 5   DROP INDEX public."IDX_p2p_dispute_messages_sender";
       public                 postgres    false    247            �           1259    92449    IDX_p2p_disputes_admin    INDEX     V   CREATE INDEX "IDX_p2p_disputes_admin" ON public.p2p_disputes USING btree ("adminId");
 ,   DROP INDEX public."IDX_p2p_disputes_admin";
       public                 postgres    false    246            �           1259    92447    IDX_p2p_disputes_initiator    INDEX     ^   CREATE INDEX "IDX_p2p_disputes_initiator" ON public.p2p_disputes USING btree ("initiatorId");
 0   DROP INDEX public."IDX_p2p_disputes_initiator";
       public                 postgres    false    246            �           1259    92446    IDX_p2p_disputes_order    INDEX     V   CREATE INDEX "IDX_p2p_disputes_order" ON public.p2p_disputes USING btree ("orderId");
 ,   DROP INDEX public."IDX_p2p_disputes_order";
       public                 postgres    false    246            �           1259    92466     IDX_p2p_disputes_progressHistory    INDEX     f   CREATE INDEX "IDX_p2p_disputes_progressHistory" ON public.p2p_disputes USING gin ("progressHistory");
 6   DROP INDEX public."IDX_p2p_disputes_progressHistory";
       public                 postgres    false    246            �           1259    92448    IDX_p2p_disputes_respondent    INDEX     `   CREATE INDEX "IDX_p2p_disputes_respondent" ON public.p2p_disputes USING btree ("respondentId");
 1   DROP INDEX public."IDX_p2p_disputes_respondent";
       public                 postgres    false    246            �           1259    92450    IDX_p2p_disputes_status    INDEX     T   CREATE INDEX "IDX_p2p_disputes_status" ON public.p2p_disputes USING btree (status);
 -   DROP INDEX public."IDX_p2p_disputes_status";
       public                 postgres    false    246            �           1259    92491 #   IDX_p2p_orders_cancellationMetadata    INDEX     l   CREATE INDEX "IDX_p2p_orders_cancellationMetadata" ON public.p2p_orders USING gin ("cancellationMetadata");
 9   DROP INDEX public."IDX_p2p_orders_cancellationMetadata";
       public                 postgres    false    244            �           1259    75374    IDX_sweep_transactions_deposit    INDEX     f   CREATE INDEX "IDX_sweep_transactions_deposit" ON public.sweep_transactions USING btree ("depositId");
 4   DROP INDEX public."IDX_sweep_transactions_deposit";
       public                 postgres    false    237            �           1259    75435    IDX_sweep_transactions_status    INDEX     `   CREATE INDEX "IDX_sweep_transactions_status" ON public.sweep_transactions USING btree (status);
 3   DROP INDEX public."IDX_sweep_transactions_status";
       public                 postgres    false    237            �           1259    75658    IDX_transfers_createdAt    INDEX     V   CREATE INDEX "IDX_transfers_createdAt" ON public.transfers USING btree ("createdAt");
 -   DROP INDEX public."IDX_transfers_createdAt";
       public                 postgres    false    241            �           1259    75657    IDX_transfers_status    INDEX     N   CREATE INDEX "IDX_transfers_status" ON public.transfers USING btree (status);
 *   DROP INDEX public."IDX_transfers_status";
       public                 postgres    false    241            �           1259    75656    IDX_transfers_userId    INDEX     P   CREATE INDEX "IDX_transfers_userId" ON public.transfers USING btree ("userId");
 *   DROP INDEX public."IDX_transfers_userId";
       public                 postgres    false    241            �           1259    42581    IDX_wallet_balances_baseSymbol    INDEX     d   CREATE INDEX "IDX_wallet_balances_baseSymbol" ON public.wallet_balances USING btree ("baseSymbol");
 4   DROP INDEX public."IDX_wallet_balances_baseSymbol";
       public                 postgres    false    230            �           1259    42580    IDX_wallet_balances_userId    INDEX     \   CREATE INDEX "IDX_wallet_balances_userId" ON public.wallet_balances USING btree ("userId");
 0   DROP INDEX public."IDX_wallet_balances_userId";
       public                 postgres    false    230            �           1259    75529    IDX_withdrawals_createdAt    INDEX     Z   CREATE INDEX "IDX_withdrawals_createdAt" ON public.withdrawals USING btree ("createdAt");
 /   DROP INDEX public."IDX_withdrawals_createdAt";
       public                 postgres    false    239            �           1259    75528    IDX_withdrawals_status    INDEX     R   CREATE INDEX "IDX_withdrawals_status" ON public.withdrawals USING btree (status);
 ,   DROP INDEX public."IDX_withdrawals_status";
       public                 postgres    false    239            �           1259    75527    IDX_withdrawals_userId    INDEX     T   CREATE INDEX "IDX_withdrawals_userId" ON public.withdrawals USING btree ("userId");
 ,   DROP INDEX public."IDX_withdrawals_userId";
       public                 postgres    false    239            �           1259    42582 )   UQ_wallet_balances_userId_baseSymbol_type    INDEX     �   CREATE UNIQUE INDEX "UQ_wallet_balances_userId_baseSymbol_type" ON public.wallet_balances USING btree ("userId", "baseSymbol", type);
 ?   DROP INDEX public."UQ_wallet_balances_userId_baseSymbol_type";
       public                 postgres    false    230    230    230            �           1259    42259    idx_wallet_keys_user    INDEX     P   CREATE INDEX idx_wallet_keys_user ON public.wallet_keys USING btree ("userId");
 (   DROP INDEX public.idx_wallet_keys_user;
       public                 postgres    false    227            �           1259    42258    idx_wallets_user_blockchain    INDEX     _   CREATE INDEX idx_wallets_user_blockchain ON public.wallets USING btree ("userId", blockchain);
 /   DROP INDEX public.idx_wallets_user_blockchain;
       public                 postgres    false    228    228            �           1259    42260 *   idx_wallets_user_blockchain_network_active    INDEX     �   CREATE UNIQUE INDEX idx_wallets_user_blockchain_network_active ON public.wallets USING btree ("userId", blockchain, network) WHERE ((status)::text = 'active'::text);
 >   DROP INDEX public.idx_wallets_user_blockchain_network_active;
       public                 postgres    false    228    228    228    228                       2620    75345 -   wallet_keys wallet_key_user_reference_trigger    TRIGGER     �   CREATE TRIGGER wallet_key_user_reference_trigger BEFORE INSERT OR UPDATE ON public.wallet_keys FOR EACH ROW EXECUTE FUNCTION public.check_wallet_key_user_reference();
 F   DROP TRIGGER wallet_key_user_reference_trigger ON public.wallet_keys;
       public               postgres    false    250    227                       2606    84062 )   p2p_orders FK_073c9b55bd629fb9fca1b593258    FK CONSTRAINT     �   ALTER TABLE ONLY public.p2p_orders
    ADD CONSTRAINT "FK_073c9b55bd629fb9fca1b593258" FOREIGN KEY ("buyerId") REFERENCES public.users(id) ON DELETE CASCADE;
 U   ALTER TABLE ONLY public.p2p_orders DROP CONSTRAINT "FK_073c9b55bd629fb9fca1b593258";
       public               postgres    false    244    4992    220            �           2606    33787 4   payment_method_fields FK_26f2438e43b6cab038d8e580f0b    FK CONSTRAINT     �   ALTER TABLE ONLY public.payment_method_fields
    ADD CONSTRAINT "FK_26f2438e43b6cab038d8e580f0b" FOREIGN KEY ("paymentMethodTypeId") REFERENCES public.payment_method_types(id) ON DELETE CASCADE;
 `   ALTER TABLE ONLY public.payment_method_fields DROP CONSTRAINT "FK_26f2438e43b6cab038d8e580f0b";
       public               postgres    false    224    5002    223            �           2606    42034 2   p2p_trader_settings FK_2ea92e7c08d6b5950986f153d21    FK CONSTRAINT     �   ALTER TABLE ONLY public.p2p_trader_settings
    ADD CONSTRAINT "FK_2ea92e7c08d6b5950986f153d21" FOREIGN KEY ("userId") REFERENCES public.users(id) ON DELETE CASCADE;
 ^   ALTER TABLE ONLY public.p2p_trader_settings DROP CONSTRAINT "FK_2ea92e7c08d6b5950986f153d21";
       public               postgres    false    4992    220    225                       2606    84067 )   p2p_orders FK_2eeb0c80a832f5fc67546ed8df1    FK CONSTRAINT     �   ALTER TABLE ONLY public.p2p_orders
    ADD CONSTRAINT "FK_2eeb0c80a832f5fc67546ed8df1" FOREIGN KEY ("sellerId") REFERENCES public.users(id) ON DELETE CASCADE;
 U   ALTER TABLE ONLY public.p2p_orders DROP CONSTRAINT "FK_2eeb0c80a832f5fc67546ed8df1";
       public               postgres    false    4992    220    244                        2606    75722 )   p2p_offers FK_56d2ea58f254c9ab32ae26e1a74    FK CONSTRAINT     �   ALTER TABLE ONLY public.p2p_offers
    ADD CONSTRAINT "FK_56d2ea58f254c9ab32ae26e1a74" FOREIGN KEY ("userId") REFERENCES public.users(id) ON DELETE CASCADE;
 U   ALTER TABLE ONLY public.p2p_offers DROP CONSTRAINT "FK_56d2ea58f254c9ab32ae26e1a74";
       public               postgres    false    243    220    4992                       2606    92663 0   platform_settings FK_7320566fa1390375b0d64d87803    FK CONSTRAINT     �   ALTER TABLE ONLY public.platform_settings
    ADD CONSTRAINT "FK_7320566fa1390375b0d64d87803" FOREIGN KEY ("lastUpdatedBy") REFERENCES public.admins(id) ON DELETE SET NULL;
 \   ALTER TABLE ONLY public.platform_settings DROP CONSTRAINT "FK_7320566fa1390375b0d64d87803";
       public               postgres    false    5034    233    249                       2606    92347 0   p2p_chat_messages FK_a219cb8448f0e7255c1c8283ad9    FK CONSTRAINT     �   ALTER TABLE ONLY public.p2p_chat_messages
    ADD CONSTRAINT "FK_a219cb8448f0e7255c1c8283ad9" FOREIGN KEY ("orderId") REFERENCES public.p2p_orders(id) ON DELETE CASCADE;
 \   ALTER TABLE ONLY public.p2p_chat_messages DROP CONSTRAINT "FK_a219cb8448f0e7255c1c8283ad9";
       public               postgres    false    245    244    5073            �           2606    75618 !   address_book FK_address_book_user    FK CONSTRAINT     �   ALTER TABLE ONLY public.address_book
    ADD CONSTRAINT "FK_address_book_user" FOREIGN KEY ("userId") REFERENCES public.users(id) ON DELETE CASCADE;
 M   ALTER TABLE ONLY public.address_book DROP CONSTRAINT "FK_address_book_user";
       public               postgres    false    220    240    4992            �           2606    75320 *   admin_wallets FK_admin_wallets_wallet_keys    FK CONSTRAINT     �   ALTER TABLE ONLY public.admin_wallets
    ADD CONSTRAINT "FK_admin_wallets_wallet_keys" FOREIGN KEY ("keyId") REFERENCES public.wallet_keys(id);
 V   ALTER TABLE ONLY public.admin_wallets DROP CONSTRAINT "FK_admin_wallets_wallet_keys";
       public               postgres    false    236    5016    227            �           2606    75685 %   conversions FK_conversions_from_token    FK CONSTRAINT     �   ALTER TABLE ONLY public.conversions
    ADD CONSTRAINT "FK_conversions_from_token" FOREIGN KEY ("fromTokenId") REFERENCES public.tokens(id);
 Q   ALTER TABLE ONLY public.conversions DROP CONSTRAINT "FK_conversions_from_token";
       public               postgres    false    5022    229    242            �           2606    75690 #   conversions FK_conversions_to_token    FK CONSTRAINT     �   ALTER TABLE ONLY public.conversions
    ADD CONSTRAINT "FK_conversions_to_token" FOREIGN KEY ("toTokenId") REFERENCES public.tokens(id);
 O   ALTER TABLE ONLY public.conversions DROP CONSTRAINT "FK_conversions_to_token";
       public               postgres    false    229    242    5022            �           2606    75680    conversions FK_conversions_user    FK CONSTRAINT     �   ALTER TABLE ONLY public.conversions
    ADD CONSTRAINT "FK_conversions_user" FOREIGN KEY ("userId") REFERENCES public.users(id);
 K   ALTER TABLE ONLY public.conversions DROP CONSTRAINT "FK_conversions_user";
       public               postgres    false    242    220    4992            �           2606    33792 .   payment_methods FK_e819b8faad4c4b3371c37b77de2    FK CONSTRAINT     �   ALTER TABLE ONLY public.payment_methods
    ADD CONSTRAINT "FK_e819b8faad4c4b3371c37b77de2" FOREIGN KEY ("paymentMethodTypeId") REFERENCES public.payment_method_types(id) ON DELETE CASCADE;
 Z   ALTER TABLE ONLY public.payment_methods DROP CONSTRAINT "FK_e819b8faad4c4b3371c37b77de2";
       public               postgres    false    222    223    5002                       2606    92352 0   p2p_chat_messages FK_ec08cddbc4dda007dc74db9525b    FK CONSTRAINT     �   ALTER TABLE ONLY public.p2p_chat_messages
    ADD CONSTRAINT "FK_ec08cddbc4dda007dc74db9525b" FOREIGN KEY ("senderId") REFERENCES public.users(id) ON DELETE SET NULL;
 \   ALTER TABLE ONLY public.p2p_chat_messages DROP CONSTRAINT "FK_ec08cddbc4dda007dc74db9525b";
       public               postgres    false    245    4992    220                       2606    75727 )   p2p_offers FK_ef6bafe21786657d0850862ad23    FK CONSTRAINT     �   ALTER TABLE ONLY public.p2p_offers
    ADD CONSTRAINT "FK_ef6bafe21786657d0850862ad23" FOREIGN KEY ("tokenId") REFERENCES public.tokens(id) ON DELETE CASCADE;
 U   ALTER TABLE ONLY public.p2p_offers DROP CONSTRAINT "FK_ef6bafe21786657d0850862ad23";
       public               postgres    false    5022    243    229                       2606    84057 )   p2p_orders FK_f236ce259a7d86d88a0f6d120e1    FK CONSTRAINT     �   ALTER TABLE ONLY public.p2p_orders
    ADD CONSTRAINT "FK_f236ce259a7d86d88a0f6d120e1" FOREIGN KEY ("offerId") REFERENCES public.p2p_offers(id) ON DELETE CASCADE;
 U   ALTER TABLE ONLY public.p2p_orders DROP CONSTRAINT "FK_f236ce259a7d86d88a0f6d120e1";
       public               postgres    false    244    243    5070            �           2606    75406 0   gas_tank_wallets FK_gas_tank_wallets_wallet_keys    FK CONSTRAINT     �   ALTER TABLE ONLY public.gas_tank_wallets
    ADD CONSTRAINT "FK_gas_tank_wallets_wallet_keys" FOREIGN KEY ("keyId") REFERENCES public.wallet_keys(id);
 \   ALTER TABLE ONLY public.gas_tank_wallets DROP CONSTRAINT "FK_gas_tank_wallets_wallet_keys";
       public               postgres    false    227    238    5016                       2606    92436 4   p2p_dispute_messages FK_p2p_dispute_messages_dispute    FK CONSTRAINT     �   ALTER TABLE ONLY public.p2p_dispute_messages
    ADD CONSTRAINT "FK_p2p_dispute_messages_dispute" FOREIGN KEY ("disputeId") REFERENCES public.p2p_disputes(id) ON DELETE CASCADE;
 `   ALTER TABLE ONLY public.p2p_dispute_messages DROP CONSTRAINT "FK_p2p_dispute_messages_dispute";
       public               postgres    false    5088    246    247                       2606    92441 3   p2p_dispute_messages FK_p2p_dispute_messages_sender    FK CONSTRAINT     �   ALTER TABLE ONLY public.p2p_dispute_messages
    ADD CONSTRAINT "FK_p2p_dispute_messages_sender" FOREIGN KEY ("senderId") REFERENCES public.users(id) ON DELETE SET NULL;
 _   ALTER TABLE ONLY public.p2p_dispute_messages DROP CONSTRAINT "FK_p2p_dispute_messages_sender";
       public               postgres    false    220    247    4992                       2606    92419 "   p2p_disputes FK_p2p_disputes_admin    FK CONSTRAINT     �   ALTER TABLE ONLY public.p2p_disputes
    ADD CONSTRAINT "FK_p2p_disputes_admin" FOREIGN KEY ("adminId") REFERENCES public.users(id) ON DELETE SET NULL;
 N   ALTER TABLE ONLY public.p2p_disputes DROP CONSTRAINT "FK_p2p_disputes_admin";
       public               postgres    false    220    246    4992                       2606    92409 &   p2p_disputes FK_p2p_disputes_initiator    FK CONSTRAINT     �   ALTER TABLE ONLY public.p2p_disputes
    ADD CONSTRAINT "FK_p2p_disputes_initiator" FOREIGN KEY ("initiatorId") REFERENCES public.users(id) ON DELETE CASCADE;
 R   ALTER TABLE ONLY public.p2p_disputes DROP CONSTRAINT "FK_p2p_disputes_initiator";
       public               postgres    false    4992    246    220            	           2606    92404 "   p2p_disputes FK_p2p_disputes_order    FK CONSTRAINT     �   ALTER TABLE ONLY public.p2p_disputes
    ADD CONSTRAINT "FK_p2p_disputes_order" FOREIGN KEY ("orderId") REFERENCES public.p2p_orders(id) ON DELETE CASCADE;
 N   ALTER TABLE ONLY public.p2p_disputes DROP CONSTRAINT "FK_p2p_disputes_order";
       public               postgres    false    246    244    5073            
           2606    92414 '   p2p_disputes FK_p2p_disputes_respondent    FK CONSTRAINT     �   ALTER TABLE ONLY public.p2p_disputes
    ADD CONSTRAINT "FK_p2p_disputes_respondent" FOREIGN KEY ("respondentId") REFERENCES public.users(id) ON DELETE SET NULL;
 S   ALTER TABLE ONLY public.p2p_disputes DROP CONSTRAINT "FK_p2p_disputes_respondent";
       public               postgres    false    220    4992    246            �           2606    75369 6   sweep_transactions FK_sweep_transactions_admin_wallets    FK CONSTRAINT     �   ALTER TABLE ONLY public.sweep_transactions
    ADD CONSTRAINT "FK_sweep_transactions_admin_wallets" FOREIGN KEY ("toAdminWalletId") REFERENCES public.admin_wallets(id);
 b   ALTER TABLE ONLY public.sweep_transactions DROP CONSTRAINT "FK_sweep_transactions_admin_wallets";
       public               postgres    false    5044    237    236            �           2606    75359 1   sweep_transactions FK_sweep_transactions_deposits    FK CONSTRAINT     �   ALTER TABLE ONLY public.sweep_transactions
    ADD CONSTRAINT "FK_sweep_transactions_deposits" FOREIGN KEY ("depositId") REFERENCES public.deposits(id);
 ]   ALTER TABLE ONLY public.sweep_transactions DROP CONSTRAINT "FK_sweep_transactions_deposits";
       public               postgres    false    234    237    5039            �           2606    75364 0   sweep_transactions FK_sweep_transactions_wallets    FK CONSTRAINT     �   ALTER TABLE ONLY public.sweep_transactions
    ADD CONSTRAINT "FK_sweep_transactions_wallets" FOREIGN KEY ("fromWalletId") REFERENCES public.wallets(id);
 \   ALTER TABLE ONLY public.sweep_transactions DROP CONSTRAINT "FK_sweep_transactions_wallets";
       public               postgres    false    228    5020    237            �           2606    75651    transfers FK_transfers_tokens    FK CONSTRAINT     �   ALTER TABLE ONLY public.transfers
    ADD CONSTRAINT "FK_transfers_tokens" FOREIGN KEY ("tokenId") REFERENCES public.tokens(id);
 I   ALTER TABLE ONLY public.transfers DROP CONSTRAINT "FK_transfers_tokens";
       public               postgres    false    229    241    5022            �           2606    75646    transfers FK_transfers_users    FK CONSTRAINT     ~   ALTER TABLE ONLY public.transfers
    ADD CONSTRAINT "FK_transfers_users" FOREIGN KEY ("userId") REFERENCES public.users(id);
 H   ALTER TABLE ONLY public.transfers DROP CONSTRAINT "FK_transfers_users";
       public               postgres    false    4992    241    220            �           2606    75522 !   withdrawals FK_withdrawals_tokens    FK CONSTRAINT     �   ALTER TABLE ONLY public.withdrawals
    ADD CONSTRAINT "FK_withdrawals_tokens" FOREIGN KEY ("tokenId") REFERENCES public.tokens(id);
 M   ALTER TABLE ONLY public.withdrawals DROP CONSTRAINT "FK_withdrawals_tokens";
       public               postgres    false    229    5022    239            �           2606    75517     withdrawals FK_withdrawals_users    FK CONSTRAINT     �   ALTER TABLE ONLY public.withdrawals
    ADD CONSTRAINT "FK_withdrawals_users" FOREIGN KEY ("userId") REFERENCES public.users(id);
 L   ALTER TABLE ONLY public.withdrawals DROP CONSTRAINT "FK_withdrawals_users";
       public               postgres    false    220    239    4992            �           2606    42253    wallets fk_wallets_key    FK CONSTRAINT     �   ALTER TABLE ONLY public.wallets
    ADD CONSTRAINT fk_wallets_key FOREIGN KEY ("keyId") REFERENCES public.wallet_keys(id) ON DELETE CASCADE;
 @   ALTER TABLE ONLY public.wallets DROP CONSTRAINT fk_wallets_key;
       public               postgres    false    5016    227    228            �           2606    42248    wallets fk_wallets_user    FK CONSTRAINT     �   ALTER TABLE ONLY public.wallets
    ADD CONSTRAINT fk_wallets_user FOREIGN KEY ("userId") REFERENCES public.users(id) ON DELETE CASCADE;
 A   ALTER TABLE ONLY public.wallets DROP CONSTRAINT fk_wallets_user;
       public               postgres    false    228    220    4992            �   t  x�Օ�n�@��y�Q6$��������*�JYUsm����Q���$��**]5�G:���=�s��zY.V��Wx<؇���������=�h}�����y6f2���u��δ�$���vw��uXo3Й�ia�/\�~i���_t����_'��s1�)��b`��)� 2EԒ譊�i'���b4Qǀad�@��F� 9��;����[V�r�,�=a�
J�,)�%5��4.91̸�9K����݅]8����.��_G�;$�Bs�s��Zj���z	���z:��+0i@ݬfU}����h���
%�2/�Lr:P��Xܬf��n����$$��p�c>�Ra�G��N�hBir�@�HBb��J		�p,U���S�|lf��6bM��p:*&�)���1�21Ѩ�\=�ҷ,��l�Y�q��C�=8��J����+��թ[YA��HPt��S8\߂�j�GjF����d��=\-f��E[ܪy{(~<7@�vn�n����$G2�h�՚�%�F}'�"E�!6<�,�P�R���6Bp ���T�����\._�B!"�X���Ą�P�*5�\��J
:>�E1�4@(�WC�#jp\�3������"�      �   �  x�͖KS9���]ِT!׽z�Y����)�&���W��h�y���a*0$�Ż��ܒ>�>�nu�5���˅?�������:;K���0��?��aB����<�7��zE16i>_�ޟ����~�j�.SN���N�S��}h�)v��`q�|������a�a-A�"1�3�30������k��Zj'�I���yVvR��|��O}����MOcrv �s��@�AJK�����s�G&-&�r&"�� �3q9or�|y�,�y�8pŀ3���6 :Ji ��c�c�7�z{�O�[����Uý�ϭ��?�m�v�b��$���\ I�,s�5H�I����<� q��
�{�������b�bt����'t.�0�4z�����.;�Y�:���*c�l�\2@���h�M22�&xp� �3��f�\v@-իğ�U&.�d�e�޺B�Dd>��/�ᤄ�������fg<�\]��E}�&]}�x�t<���/��IE�q ŤȞ�w��K������Ӗ�����~RW�v��}��aI&���0%��1�^�~���b{��PNg�7?������:NN��,O�u��r��^{g9CEY#,�(��� I������ʡ}����ʴ%'!K²Ԧ��$�Nx��$�C$������<2ݫ��ߞ���ǋ݁�|����N�f��Z�"�cv���Q��t�9*�r�SH���Hˎ��(�O�*���eΙ�:/s�<�\�'GD򂂍�H?�t}2��<|M�q<������}#�}{qb뇼府�,&QnRGd��"��tF�����uG  ����U&] ��g^�~PB(���cw�#j���x���O7���n84��ܝ���9��E}sW����n�H�S)�k��j���\/�����M��+,�7t�����ʜ�G덉�)[R�1�	Πpщg��9�ٜ��x��/�\4��G���'0^���cM,��c<��~Қ�C$Y�c��e�a������6�w���u��      �     x���]o�0���o���)����St2��Қu$\ܯ.���y������1���	T�1W��E�JC%� ��1T\�s�C� k�E�u��V�Rw"�%o���m%�����i��လ\B��5	v����ҤA�Ry��I��0�=p��I~�������o�>-_6����^ѷ�
�C�˅���϶�g�ND�:\^�S��z�u���]��[٭�<ύ�� F�3�m�l4���E�΄����-��,�y,I��=��z��f\}      �   a  x�ݗ�n7�����8��H���
Ҵ5�@��^�6h�5|(ڷ/ǎ��q�N�E�`I?W3;��������i���p:�(��չ����g���gӓw����⬟��6��G�?����|��dўX_�_I���W�=��_��~���h���O����|~qfK��[d{~�_�����ӯ�_�}�fz�W�`.�e���S`��G���޳io�<ttp�����Z��0W�%���)Ve��u�`�dp�Kp�U���biK\
�������[�L���>�1�����?��M!D��=k@!�>�kAXfR
�)�D7�Yv�(@���C�ս���ǩ�'﻽�e��yt��*���9*�����`zqx�ӫ�Gӏ�����/�?��h��I����Ru�C�lvr��&"U�B���TWK0:����롗\�C�����������W�"�:+�/��lĕ�+�9b��α���`t���т�h����C�����BX�!g��JÉ��[��,�y^2)�Ȝ ��
ɍ$VD�,I�n�.)Í5�>]�L��6�;�SEY\�%�{&Ǳhl@��ǒS����j9	x{�`i��W^fUN(ԝc�)�������09���ۡՑ�d��`����;���e�c_G��㊍��c�iFNv�&�@קϨ�I�s0Hb��Д�	�4��Xf���ԝC� f���)��h�8�I��q;~��`�-Wng��@��RҶȈ�`�ElPw��92�5E���NF*�����!�R���f|OcX�:߼�U�;v��5+ūV;0z�8��톨�),g�h��j��1x4D�b�p��w���M��U��Y��Jǧ��ҵgk�� ��"e��#ZYi�U~㡀�*3��&fq,��l��0c-�w,κ�{		a�d��u2ɋ\׈@���|X�Xڜ�����������Ρ�L)�Q�?|�r�S��]J-Uˤ�`+�J�]��B�����9ks�L����S��*��%݂>R�Qok]��e��ۚY�k���D��6��h��sp���R�y���,��Ӝ�E�P����+�yQ��fV��8�(ۅ#ؖ��!oP��G��=T�(      �   ~  x�ŒMn�0��>�C@	`��d�Į+ ���Ξ�)�
h�@��J��z��'�du�d�l8�7~�X���q������]rW��9�]
�H~
��a
{�ҟ�o/��M�,�M_�Yw9�6�y;����3��4��.�pQ��#�GL9�!qL��zNq1�B��Q�s���A���0���g/m��7�$�a����5�W3&)�/��pW�O���5�z�ҫ�I�_J��G�BFP��eI�)�QQ:����v��ng�`�ߦW+u�~?��;�����*$��HJn�F0|�_n���f\��w�g�bz�}L?>�Ȱ����$z$c��$�r���31 �n�ͩM�/��t{?~�x��=���t	��_s��      �      x��}ksE����
�0A�ȝ�w�ܺ��s���n�[>m��,7����w��ŖlI pĕ�ࠬS��Zk���Q|����O>~��o^��O��o^�|r���ߞ��N>x���}�>��o�ӧ���������?~����1>�g/^=?��<}Q������<��߾8������~��ɋ�����zV����x>��=��h}�����|�
�~��s���׳��{[��/������~�����v�oj��e������%��K.���܈�>����1��i�����Ep��ԋ�>���C��bV�®��F-S����]�y�+���-=xZ88^p��(��Zb�.�������d��"����`՚����U3(\|�fҩ�Rsgq+�?����]^�����st���`�������jH���7u�ѽ�c�����'\�5�ٷ��ų�Ͼ�o�����^wN}����76�w"����=�#�_m�Kʁ�Z�ٚ=�Qq�75��G�!:<����nd�x!���\�׭���/q�篞>��y��yY�_�8>w*q�(��O�O�Oɭ�y����'�O�������<�����������x �}�V��������ϱu��mx�J4jK���KIŖB詄����.E��X<�cIg&�p-�Q� 5 ��H����N)��
; ZwC
��Ol#�37�$Vq���"Z�K&�Ͼ{�?�z���bD�4�+܌�����?���~�~�Ń?>;�Vb���З�ن��2��P�p*=`Y�5��<�T��m�Xj��9�!T<���������_�߿,?�ߕ��=yU��{���ٟ^�������H'N=@����&v+z�QF��4,Ԁc��-ƔU)��j��!��z��Ȅ���R��K�C�d����$�9�HKV��L�	e��B$�b-��C8�1:�ʹviW�U�����{-Y|i�G�␣��rN���������۔B����F(4QL��3�3Ũ!n�t���xr�j�\m����/��$��G�h�YFr��ۉ�Ν2*���h��qE�(轁E}n�d�(��(`Hq��uЋ��o��D8_'�����q�Pi<���;�ޒ"�kC�tp�j��}���פ\� e�p@��TU���>�T�|����S���\2�HTB)V(,�i�9('� $��:����Z�cm';Z]U�ݩ%����~ �cX^Qնdguq>���[�������  ��i���Na䲅0�OIn^4�\3 �X���W2�x�d�(�w���%�.�ڭ�Q�3CO�<f��}8�=Գ E�1������p�����p���6-��5�7���hn!x��"���-�P�Pa���[@�Q�y�Upւ�i�2�z�Q��]@�bA)�a1���j�G��g�s��g����q�whA�-�t�<,��J��_�) u�'-�AP�(�wz�!�
�rO��:��$�.9Ɓn(���*B�D�\ԕ�H ���66ݒ��l]X�6�@�l�a)Cܯ��7Ys�� ��&�+Z���*��{Ú���.}��簔����L�`�ۭ�Q������ *���!!�������H\M$F�(����=���Y��o��#MlqeƁU`���ť��
��8�R�te�+�$t�3�o�	��R���F%�k�9/�p�}}�\�k~��Yz�����=��8����{u6�~�zB�4�)3�v��n���=���3/�!rĀr��j���dM�>ቪ��>��^`���|-u�"��}@׷���p����+���O��1�7���g�<�!o����W��W�H����p.������ox��>��}��wY���ItBtJc�B����/Z}B�\�����1b5��ir0i�.P6Y�H�d��}�KP;sT�u(��A��)�6�BGU�����+�(.U`¡�y��n.K��-\
n
�FX�X琑 jf*�A�0OG�=E	���4\�� ���KeM��H>��C|ܮ-1W��d��rO��n��Y����2�`!��>$_"�K���\�p�HV�O-�T[��]ʲ����eY����8����=#}�G~���g������_}����Oeٯ	[��VV����Ռ53r�� �^�O�XneO�G��<RiLY�4sܲ��n���w5;���B�7˦��1���_0��s�9�^u�p譊�`/	�BT	��} V{��j��,��[�ߥ�L���~N�8�W4�I3����>��������>�ߛi��>q�,��\���+��ظY���{2��Jn�J7Tjq���T��t䬬�Q7�߉zZ��>���OZ;L�A��2����i8�ڛK����v~q0�_�G��<���� �Q��x,��@LiI�Y؉^sa�@�w��43�Ps�Q,.���ugK�Wms�O�v��n���yN Gۏ��M��l��۵s��d\���5.��a��1F���q�sM��}���Z8%ŖF���KdA�(ޅ��0<����4f �5�������xo��D��(�ia�����0��TQx�3�#�Z��xn!#a��9)T�'�.^s��4��P^��"��~(����O�|�~�?y��ǻ��1;xNt�w1<P�#B.�X'���d4�r�.2x�a,�G�
�ގ�n�.���4I%�7��T��Gsڱ���d����u�����Owz�%+��k��	I����V��R݄GD�n�P����I����	��;#����w8�i!��YkV�Q��w1W	\�-!��Vԏ���1��(������4.C�^O}\��~��V�UP�j�7�'�&�,�FD��"���ԪD�j���;ͣ�u�{n�|HWi\��u�?fē��\���-��<jJ�,o[����N@���s7�����:|���K��u$������J(R�u.\�18�1�D�l��mK �|�1b��T�S:��Ր����8�^��� �C]׼ o��Q�F��K�ͫ/���8<3��w�:��:F��2p=yr���ꅥ�8��ߞ5s!���	�ߝV�f7��4�5�4�C�z�\C0��>�b/uv�Fՙ�	k�;u�rsT;^�:��E��z_X��rj�|N$zc��ZmV�~�����u.7G����y�C1�а ��)����^����+�o�����#��狀��r���.��&��|��[����zS|-$��"')qN�Q��@�6#��L�JW��q�TҊ�Z�+Z�C��ɻ�������DP�jA��Kϰ��/�V��V��4)�|���"_�<qE��Upi9����ɐ�s�����)��/�P�˥�=���9��&`u5��kB���4(��]r�4g��Kã��+���A8�8WC�+�t���"����FZ�%ï�X����
�ੱu�uwUl���.��UUN1h��gWqv�(z�F���/�c.5����⹞�~�����f����TAk���ͅ�C@���fu�G$�Q�b�n�����Nd�.���BE��V$��H��#���<� ��{+F���RNR����e+��-�[u ���2T�Q[��U�l�en8]`CP�k����ۥ�Dո� B���1MC�t�q�m\;K;��׺�����m7>n����m����7or�¸��G������0����?_})_�F���g�ӳ?�C�s��9v;�9xMp���v���]m��~������;�q��ۭ�����f���f�!���3�C~��<���9�z9��[�q�m��MW����7)-EB9^D(�
��!-�"���o�����A�����?Om.���ŦR�C�V������Eh 6�7�������px?�;	�9�<��΍T�����Q�vN8��ǝ���􋄃�[oH���&9u�J���-z�1����^8C>J��-:R)
��݆ܻ�cW��{Թ �  %ɷQ�<H݇I �vR	��)�w9�N�+�-^���ߏ�ǩ�s
J�t���s�P?�o`����㪽��S�V���&���x��?�HE[.9����ѼIYB�r0Z�[���qo�ͥ�#�:
\�\��)T73g��R���?Sb������tw�,C'�������2��S��{�<7T���j�a:m.N���i΋�[�~ڝ��v)?�IN	�"���=��|�%ь��������o���ڠ[oH�c�[CD$�035��f�q��;Y�:�(�!�T }���g-�m5	�uq�|wu�w!U\�|>`Et��ʥp�5��!�Nm�)��%���m����bUϝ�KZ�9s�tI�QI9�|;�A:w��.R�yV�K��K0�JZ���0Pau!����q&� ��iQ���|1�v�9��:��� 6�:(�b)1e�0�l.ݐ�Ĺ�B"8�=��j��{I�%^\7�0�U��P��H��E \��)va�d��na--���c�;�[�!_1� ��.� �*�����9��XG�)�}+�� �RT����sG�ܼ��ń'�h��f�~�=� �\���)V�:;ءfK%�X�q�7�W�V�V��c� <%?W����� �f�m9�׻�&�ŋ�2��dx��WS��Ǵ�o5�\�;�o� ��O�K�~� �!�8��?�m�6����ޭ���߭�����>([���:��~�ۄ��$�)�QQ�@"�_�n���1��l5e���kG�%� �MH�З9ٌRHA�K��D8�?�*/C�n��b-�>�F�K1/�����3jxm��&��&����/m���˖�U�U�K�r\���z�û���[8�/�6�y�{�i_����������G�r������I�k��47WU������}��ŀ��ZO�3��m����ϭ:������~9tz�r��B��?�P�9@Dc,�"�f/��/7�}ju�����+D&S�Kα������o2��Y뀵����)��rT�%���(Y�`�b�#��d�a�����*��޹F�Rt��zePUgwf�\f�+<����	�3�5�Y��5��a�e�g��NpFm���^�h��U$��o��Yk@W��?{ �/��d!7ы2��ѡ��b���oÚT� ��'��'� wu���$��z����$�D�<���@⃎Z2l6.�1jm�s�ZR�J$�wߦ#��M&��Mμ}O2'�7y��mQҳW������ɳ�}�������������x�h����eT��s�@e$�7[e.Ӟ��x�g
�n=Ķ�\��#lC��N`������t�DC�7bo��S�26J�\qV_Q�����s����e�Keeŷ����m^��J����]2��X�ce�7*<����sC�����z�[��ċ�f�eW6��4r���]��� ���>�NoK1��J7�hw�V=[#
%����^�2�*i�O���� n}��Nd��'��:"�*�;�ך����f'"�������J���n�>��9(]�ڔw$_\�i��҉�`�m�������?��gsW%��w?tF���cw�B��sύ8��Esq���&����Y�u�v�t��a�"���v���a�K�~8��8�^� �W��m
?k�~&_��G7����
�
���lR��P�Q��{�ٮw���"vvH��vmq�>$w����I��>�m7kDiGs����$���m�x^��3$)� �j��y/;r������^h���Z���l��y�'����ض[
�ٚp�n��d�Wi�[1D�_Q��KrlbY�I��34���ON" ����� ���,]���>g?P�a��̾8���i�5b��7t���	(]
@�p�����܅���p�!�a�n���o�y�MD
���ac�SJ^���6�Ú����oQ��$��z�4"~r�~ϯ<��f����6l�2�����b0��v
f��-���w[��	�{;	�W�rKW6Fr��1Y ��5#�rw�͞~��L�����f܆!cd7ߋ��q��-V��"� �]���{���>Ē���0k���@���AB�O���S���9�s��H�5��`�m�[�����n�VzGO@oL���y��'�sDNJi!?!�{tI�ٻ`�����7�a6��W���]������7��      �      x�Œ�j�0E����'�K�X��
i�
���mpd��1~@���K��N�+��̽�s���m�sP:Ϡ��!�ͼuem��f�23����{c�oZ�r���8]�o�1�����7;�����!D$�"�E,b���&@�d(yJ0<���v��u��j��}:˟�~����I0�4t�C�$��	&�2'S��M�#��z@�D$�8��RЋ��M<b�d���79��� KS�㿞b�^��j��      �   �  x���KSZI��V6&U6Տӯ̊("QG$��T?��E�O?f)K��Ŧ/��{��w7�׵?;E�ݹ(&���;7�]�����{xH��܏G��A�����i<.�Y�Ϗ�O��܈����y��?������Oa�\�b�\],&�/E�ں�]�9ddV�0���I�u$m���T��,-�����c5��o!%�}�ZƂb\gm8���q�Ʋ��OT�W�]P�ja��*��#���1hC�^�����l�u�)��r�h��W_��p-$�g�Kq�.�/ڧ��q�8�(���F���Ac��O��TD8�	X��14� �E���/��T��׻�➻3I�	�t"�B"^C��**���mӗi^���BT7��w�_�{�OM��;AXJ��'6ER"�T����{!�+�3+?��T�\�k���L(�'8���7JY`Q&��|����M�0��ꗹ5fyW]�̢�j�ϳ��J�ޜN��Y�S�S��p�c�gq�����"5��Mu��UƞA �q(�q����dL(�ߨo��pϙ�7����-^����w�N��o�t������Fr\}s�n#�(ʨżcqGu`PJK���ku��M�"$tp���Ĺ��,$q*�5�l���;�|m�m;�/sO���ɬu2x�����eK�?�E�(oq�g�B���Ѡv�
0��/���x>`�t�(B�`c��sV�u[�[=ީɩ��/����RG��}���8����s�N�ZH.�(��*��.�՚���5Y@V�����7�=��c�(�|�LN�Q*�r���\�&oz|������j4��?�jc�:=��q���I.A��	� PG�ל(�Y�L;���� ���ꞃ+!Dt
�;+�VG
�W��Mv|��gu�9����vZ�|�<��o�~پmM���&[�ׄs�e�l<��`���M������Q\B�������k�c񃃿 �B      �   �  x��[o�0���),4)�ؐ��)��HU5�=N��*�QT���@BڄUڦ�T��9���x����y�������a��ģ�rt,��*[GJ�H�(�
����U�#_�"���E�
��L��؂��N��s�f����wL��l�v�����`L�"SS����Lu���d(��]-���Z��I�=�WfR,тeB!��4]��:AK��y$shH�i�K���}�t�4A$h)՜glɢ�N��T;CO��+��!m��j������|�0r6"��m�ִ���'����e�4#<jj�/M����]K���?6�s��d:.�4�TS���"��ְ�ô��0>#�8��`�?���� ]׷��]�`8��߿yˣ�]˴}�f.<�]bP۶'�;]n;F�`�s��� ��6�'���gM^��R�@h}�r�����&�2��/�t�q����j�[>��<7��tw|LEϡ�p8	����pl���M�ݳa4��w�ǡ�T�׌�9��9J�$	k�^��;8�0�W� v��
���¹��6<ny�[��ϭ���><)��Rj��S�{�I|���ڎ%(&0������A�g��Y�s?���Je�%}%�~^$Q7��~!��[�f��#ѵ�d)���T�!7�~j�V2v/Z>�q����r���0��r��R�_X�Q5�      �   >  x���[o�8���+�����E�l�c'���6be��Zc��$
"�4��K]��X`1�S f�p8���cg6�Nq�����ؖ\�+�Hn�OZd�4ϊO�N�3���5~|�_9_�[Ǎ���[���a�-x�)($���Y̝�b��8���t������۟7����*w���,?��<�+�
�L��5��1N�E������,A2����������	�N&
i�h<�ƽH�����ȷ�XC�R$���Hi���37�X^ �H�����ɡZ�e\��h-�B2:��=��P��� ��d�IXӫ�A�gP��&at$#L⵮�ZlL�T9�$�.��o�y�=�-����`�	�;!3ХX��	�hj�z�A�8P�4�LKA�2�XP�r�8O�x��5A�2��<|v\��_�q<��U��tt�|�Q`���<H˺`
��xܖ'�O�0�&��D�����Tt<��ᎍ�L���~�#�:���N3����C�	��ӎO�s�q��x�=�#K;9���&v� ���|�$t0æS!�����5��mw����hԄaE!�NS�6
�J���>���dX���B=�B*��$�$t0��l�ջҐu�#�ޘ���}��k-^��~��_���`c#�t,������EAY-W�lh~��B2:��B{�Ƀ,�J!Qdy��o �Ynr������h����|��H��3�[o��iכ�^$+�����R(7��]0��-�.)�o^{z�{	�T����_	����	Jݡ�
�L�]�����s�j�_BY��b���
 �)�q�hnR����<�Y�C)C�͇��s%۴�<�H����Z�:���V#z�!LT&GM��`���o��x��7�%���&�7+�R|W�s螾�W�qZ���z65��j@OU%r8�]��AGv��B�=��*:�&�Y�.��	��jT���RHGG��3q�&U�i���ic��谉lvj�9�)�F�V!Mx���,3�6<�"�_��M"�ӫ��4m#��zVe��#l��=*N��;W;3�Э��/�����^�      �   	  x��XMs����WLXI$W	$ �_���,KkWdiˤ���5�� vf ���/��%U�u�%y= iګ��rK.$>8�ݯ_�����Ż{s��aM��J�k���y��o��;i١ʎ�[7�5Fi���ʕxг�6¨�)]���е���KeτS�{�H얝9����l޼\��nTŗ�֔t-�45/�T}�{��|vu{1g��d���89ɂ$ʒ`��i0��D�$�irp�x)���R���q(�K6��������[��L���I�5"ds�+K�.o3_,���\�;U/�ns�W�^q��z�4��Ɋ�߀�Y-�V2S�O;�4L����jĽ�姏���L�V�{�1�l�MÌ��1��BY�H1�.�8w��;�G ;wZl˪e����ɠ9=i�ӓR�~m��:����ҩ*�N�L���dA�0�NP�R�w[�
�79��m��7��6��]�/�-d)��W��0n��\f���Ҭ���Y|y�e�>���:|]j>�ď��lk%�n�i�18�c+�
V�r���_��Z���l����y.�wFORs���W|mY�Wu�y���l�����gOs�+��\y>m2q���Kd퇒�gX;����[��y>I��ɕ6�D�߃[�N�����ܱz��r�LM;}���q��rg��w7w>���+�Z���d�S���uU�EI쮗{�bcB>3|���_��N�B}$k���T�k��k48����P�δhfq��0	�)�F���x��#t����������~�5�x0Pղ�)uG�t4�vzP������e	���q�(di��� �Fa8�fӤ��Y~�^X�"�$Iǳ�o���Nb�/�I4ɧi��8�D2���$M'3>�s��Q4�|8�!O8��q�x>J9���E4��{��`�}S� �R/Kϲ@l�h��7�mvp��\���˫7���]�,^��������+NΣi��`4�Av�X�,�e31f���#�Kw��`�eA�/��{��{j4�jJI������~{'�����B�Z�γ][l��R���%032k=G��nW�M���x�^.���1���(CxD��>�hB����kp�>*P�S�Q�ȿj�}��C������e��ꀼ�����4;o}_�;w��Ak���쵢�G�+A��M�(g}� ��:Gڢm��FsK[G
�y�E�����T��J=���m�lu��N�k���89
���v�'�� ��ŝ(���o=�ѹr
�V
��B�wfZ�*Lİf��`P����\!�����3~`-�>��9<(�4��X\�+9�'���9JO�-�Π���>{t����m�,���,	D����<qNx˅є�LQ�����}�J&����k�R�)��<LO��}�i;���z_<�t�ض˥����R�Y�N���Do8QHA^���%���6\"���Ȯ�X[����D�����W�
�g�3J�J��P��((�J:TM"���_,͎]y����y1{����T-뭨��&�Qҏ�Y<�<����pڟ�Е�B�nց�g�L幄w��%�Ia2���a4��&�����R8�F"����x:J���gq8��|wQ���0�yM��X��8͇r�����)$�R̜���̅3f�	�S�4! s@:�,�F��t�>�u�[�.Ԋ�족�]��j��7W�i����5*�
�{���f���q�;v��_�B�^7W,Sh�T%��Lþ��~�C���~Jt4([*��H���g@}����G�_��]a0�J�T�1Ra�,��֊��Fh��	?���cH�C�U�a�tcmAR�4}��8��J�t�慳N'/h�x`iI`﹗R� �H������3���&�����m�$N� z�^}�:]`2���#W{x��!�>����(�JFH���q�׽�?��_�,�{F�ɟZI��R��,`
��!��,uXk���{����B����Z�"�}m}C;�%�4b�B0`��H�N}3&B� �� ^7�<���c�f�z��#c�C���q-T�Ă&�b �Ŝ'+�8H��$�4z��"P-��?��L��^�K����\@���[Ȳ��AJz�&g6$��sk�@F�X�}7��g�RV����c6�c�7F��*t\+�?]����-w�z��µ��>�]�P���x�����o���8��p:�;�}��qu�����m���n���=h:��6�a2�I��`�1�q(n���Y@���o��=�f�!      �   0  x�ݜ�nG�����Q�}�>�^,r�n8�"rv��E�-�I�z��R�%�b���� 2E�G49�����������o�˫���b���.��?�6��s��ex���I���˼��_���%��o�z{�@z�}D�O���t�+�86Y��a��z+�_���"|V��n�p����>}bx�/�}���7�%ڢ"��Z #s"h� %U,����Wͅ�c��9��s���Ϣ�a��~z󆎾��������s�a��e���l�jBJ�X5��I��E�W�t{_�Y���c�\�����}���٪�,�4�{L+z�U��sR�tI�.$��q`\5:i:p�7�Jqlt�F����U������\~����~����?����O�����xR��ֆ����Z�`�� ]��%jfs���g�`��V,"�Q�_�26��X5k��0�oR�X͛���5��-��U�Ӳ�R�]�O�ƌ5rc 0�ؠXD���ɢv
�+'`��hQ%����G���S^�a6z(���O?���޹lnï�D�YC�`R����a�����#%h���m�V��g��S�Oh���ˑS������ gG�4%&��.���S(��/(X(�;ɂOȴ*Y'��*��ݼ~����t��g���N���DL!8�န\�O-z�u2_/�� h����n����=�y�L+-81r��9��"��H^
-��Fb�!�<�Zo�Lk�~ʕ����U��|��6|�'����� jEZ�r�Gv�LJwVY�F�89��&X*8A����K(�ʠ2g��U��-��;�j��D�)����K!�wRw [�+yP��nG��D�B�U��B4�{G���r�UBR�=�w�庞��*��"������*�	�
ጱ�WR��	
t�d�MIR��A��3^@���]���&7����ի��;�g��H<��~Z�j�>��z�a���3D��#�K̛�q`,�9��ꏫr��#�c����P\Վ�!c�A3vx��t�jFjJ��a:�/)��P�����f��<!U7���Fe�О��^�i�*΍�*9@�(�FEV�9ΑN9�m�θ����Ṇ��k�o֫��r��=��NrE��tڷ�X���@�r��cק�:C�0k"�=��s&���ڤJ�g��姞�h��9n'�vS�,o��i��-�a��V�x��|I�^J����bI.::�\8��gT���U�_n/��Ӷ�T�R�i��R��^�'Y^-)Ă:P��QN��`�q����h�<�`.`�c����������Z�U͠a{�ۃ��V0�I�M	��L7� a�ޛm�߯J���̐K��űj��.�[��@f���t��؆ՃS��P�X�k���d��u�R�Y��KQ��ѧ�³���l3�&���JS�Yz�xA{樻\O�c1:��ő��Ѷ�{�;`|eV��g�$�#rEsA��3�5y�s(�y>���{�/z"g;�6`��rZxn�Nc�1k���� 8�X�\��Z��l�'M������&���M�c�w�o=���j���رφ�ݱRa����r>�Bi ���&�s��?���vϑN��o�����UU���=K2!:��BfIdk|Όl���8-d�^[C&��2,Mxҙ�ΐ�$F��8o��o�s�5Ή��1!OXWQ�Eb�b��ji�78�A���n��M�Qy�n�������� �q�:J�@V�Fxk�>핝֨�gR����G�ca9IN]���+��#�@u�h�n]H��F/�����NI�x-Z&�0��X!�yI�e��1�>�}'��$�ms����%}N�-o�Gr������b�84��5z�NA�v�S�e� ��*-u�`�;���l�n��G
	R��-��X"e��󣷢�d^\4�"�u�YQ��D��t)������mz�ԝ ���;v����9�1�3��hc�"�I���rP!}��]T���C��DLa=8ӡ�X�v̱�&��|�������$��bg�(
�"�[�Q*)'�����O�۾w�Ǥ�jVSF8} �jp=����Pȶ��oF)X��X�|(T��󮐼l�ݶ`�&���]�\�!�n��}��꫇nw�,���ù|�4�jX�l��;�������΍�4^)Wav�D�9�n�1�7Ù�����e���V�zd���`[	|�tP�1�Fߵ)%k�<��5?֢C	:� zQ�O����]%oISq}�=1Z6w�Ot���s�0�m��T�2�I��)���M��ʤ�k꺀�9u>���twv���±�-h-v�����FG���!�~�U,Xʤ\#��LL�&�f��uSVn��7�����VV���V:K�|(�R��j�������?O�G�"�\W��msjY�z��N���@s�bI�,c]g��j�s�äd��I+����m�ﶙ��������R;4lʇ�{r�c_sW'������)��^s�ړh]���+&�p�Tf�^[.w�u�S�C�\�Y�tQ&P*���r��aT,6��S��}���XO��Ť�H�RX�C|���8���,Y���I�T�	<�`�	�f�>L��aÃ��o��;�D;�5�ۿ�pH�y���Ds&Ê�횁�IV�4*t�������FǬX�%��+2֒'d��,�"���c�sy(]���N�R�߮�}qt�x}��1OP)�Ս�Tт��>��y0�ﮀo6(I�=����l��������0���Lbׯ��~�\}|�����|>��ot��U�T)��Ő��;O2}�r�=���{����U�}�B�=x���/&G�3$j)���-��%�Fm:���K�M��:?�x��oU�5�ǈBǡ���>�>3Q���JK���yM�o*T�h�u��	f��*�u&��8Z^wr>U���@Eo[����<!}1�K(c�+��������s�N�Ld�&Ny���e,*�tQ[&q@��!H�A�HQ��Z?	o��d�y��'u[�M����,�Q�rQ���A>��|�:0L9N��23�)Kڂ�/�����_zs�4�&I	}Poʩ�5-r1A&�T�1%�� 
EqÝ��ZE2�^�Du�0Rz�c6"'�6�	RVQ1D�(�Bd�����E� ����6Jt��PV))a�N���Y�Yy
�K)�x����Y)�r�m�>�U�ߓיU��-�q�ՃX��z�[�&H�LfP���B�L�M�Ƃ"#��#�롸Ha���.�4�Ԯ��v��d�\���2�pU�V8����vF��K]VTV���-��A�Rʸ��)��ͼ���3uG��j�ϳ�1��>+N����dR�`1��Vb2��OY���P1@_#v�����8�ωqQ/lH!���,�:����~���g�C��5���<32�+X��6�"ŷ 䐥�T���O�\իu��,/��W �xK�.��b�|�)2Rb���Z��O�F���G��S�rǙ�>3M.��-~��4�[LqU/���|2[~rU�ms2�2{��{�KI�l�]�y��~�v�3>�j��b�_�W��c�e�LM�Te��V��I�
e��˹��-�^��/,���      �   R
  x��[[o�}ϯ�E	�����>N�6\9��}
��Ę�2������]ʐ���JV��Ľ��9{�w�7�����/������z������W��7���z��*?%ON���	������|q����a��j���n���{����^���x���)u����|C~|���7��3��T!�8�T1]�w%P�er�����=%g��ETh�>��i�I�,k��/_�����æ>�| iw��L���^C� ��БUOv�p\m/��j�C%a�Inq���\���[�	��±�����?�����u����2E�&\-�^(�p%7gߐW��W����<E�_]|�<��_�Z���=�Z1�����KO�V��@U2�N��H�&�-^�B��'>�!)��h��� o�*h�C_QCl:XC聤v�m��P��uXm��%�
�a�rVy@�t��K��b�Uc��^�K�	^j�OH����S�AC* ��I��%0�*���2��	�eLC6��{bH��!�@��'`�68�)�3�����`d�S�DNC��2m�o�8j�f���0�ogX����3UV�STz.,�ѫ2���CW�P��YFB}��	�����4��B�t����^"_��T��
�3�)X��/�iAR����'�Z���F+�6�}%��H��%Y�`��U�oiܞ����|*m��=�>�!rJ6�Y=���/�SB*sB͓\!�(/>٨��`&h�d��H�`D��v+�7W�u��+@�� ��ږ?����,�]H�Ǽ��ˢ��S@�H��UA/�����M0��qBR]�c�����"�`l�x���̉Y����IW�Cb�
�q�SH-����� r}��WI����L���;d�t�Ɣ�-�3	_��\�W���?GN`]3L�6��8G�j�R�84�QV��,1$���T�q�����U�Z��T�|�EU�ߺ4���=��;3N �\�#�X����uV����Y�`i�©)%��J��<&lC-�ߡ�/mG6Ǜj��,�`�����C?2?4���N�� X��r����A��:'E1uS��Ey�}W� �3��k�K�
�E�!?�{8������]���=K0C#�J4�K�s3B��"�T���(TϠ��Q��%�\��=Z���+B���?��n�x�|��5�`9�Q�
 !{�dƙ�� + P���xzH�KM�^H�h�����czG�gRTh�L���1�
t�).����WE����i�+�ߦ�b�U����a�u���4��xT�,S����z
Q�QkN����k�6��]��!�W���7L�,�������Rq������`�o*�d�tU�.ީ�W��?T�56-V����-��+(}�~�-X��ȮkwЭ�wJ��$uc5jÌj(YU�FQq,�ӘAҔ��E�=�.+Pgg��rq�Q��ʅ}�nalz�M#�T~Fݤ��_2�h����(�
��6� S�.<�_����뎕F׫��PX�=6�68 �H�5#��od5A�X�k����hA��5�N�0����@Ct	��JB.�h�"�C�^�����.�:.l���z �)Wek��F�媧���U��<�4D���vgC(��hc8�Q�E��S��F����>�B�e�a�h3S�Oz�cNs��,�F����`�ewo ����("�-�nRg-�L��TY�Uh6�')��׸e��30!�Ȟ+']|�O%$��t�|���bFu��&z*c1OI]�2&L�{�:v��oa��S��ͮ��al��N1����XZ4��$�1���5�B5V93���a=�h��/48@a�.��:i�E��\|���j�b�?����� �J҆b���kE����w��&���Ӯ'�
j`�;��
�Cu����!(ţ| �^�#��j��'�p�)g���q���\l�x]��Z�9�� �U�8��_н3�C8h�&(�����6q�0x�\�x��?�rk�!�~z���Y&Ϟ�syN^��q��	FQ�����Br9��[d��<BS���ˢ8��z����z�Xݸ�@^������ݝN�v�C�����S��И�?(4n4���b�z�g,> �7�P��u�ĻSi��f�J��V)&���)I���a{�ï՟����I�M�zF^O�K��*�NZ�G(�F���a�����p�fճX;��_wG���?�����~�L��?�in܌P��T������nS�O�<� %L0_�q�I�
�˺
Ւ���i(����v2c	69M�y�JA��u0Z��q�r�n�u��w��̻T��²�qP.���4�:1�P��T:o3&�}��������Y�RfF�E��[����G\H�/)�DȶXc�}���2�������4� 9f�T�Rp�h��Qɑe�dWdt-�X�{Dr`�㘥�B� F�q'Wx�m�r� \6F'���!�8�+\#�Gk4�y��Yè�IW�Z��T�9僸G��_~Ww�s���Q__c�� ��P��ea��Ԡ Cx+�A�q2À�֍����u����?l�zE      �     x��V�n�6}�W~�.
o��'o�6.R{�8�@�"�D*QkK�$ga��u��:M�,bh��efx8<gF�����Mg�9*��2K���7&��uck�&3�hTT�VS3�a�gM����V�.��ؼi��u���n�ؔV�F7����,�	4�Ld]�/�X,6�,�j��P�YY�`Z�g5�ٌޢ���+�fP���*��0���ǜJL��M�����H��i,p`L��JB�qJ$��/m����rX�`���k��★>�q���٥�N���8�Rc��:L,,5"Q6�uvWv���jHW����5���3��"�=tn�~�����Oѝ��(/T�� ��a��]Ժ�z&7}�v����0�]_\�%T`�1��O#A=�|��;6;���ǿ�9j�fiG�v�As8��f�y�q���й��lY;��ϒ;��V�*�_n����ے�G�:~��3t2�}1=Y��9������M���ѱ$��T $�28$��iM�5R(�����qL)V,tƉ�
�e������8=�d4J+�6��7զgF��Z�֭�d��p�G�#�=pI�?  � ���5%��ֻ��_����W�'� �G���������5w����`��C�*+�Bj(��@�!��J(����i �t�C�d�M��<b�BLh�� I�
��(f_�[o:��Kݒ�S�����i
Ⱥ+��t�8���ﮖnV�c�;��mh��M���B��S/T�K��:ઊ���k�@��n��Jq�n1�����4ِ� x%i��QO�G���kp��@�"����?��켜̆\tQPZT-Ħ�y��&+�'a҈҈�Л�6��]�c�Gٹ��z��������t�	MN����ه���@`e��|�U[v�uW]���;$w:�uOZ��^Z�E��P���J� ���}_�v��ғ���� ��eQ�'>� :=�{�� |)����.$ y	�<ă<#N����� ��)��C xF���������Rَ����Ŵ˅      �     x��X[�S7~�WXyY��#����i�F�lK_����D䦓����;'$�d7,b�<�ˌ�x�}3�x8z���%�./�bUOƱZ�ş�Rr�dǩ�z�en���g�z�鹝�ͳ͋0��fm��U��Y\�٢��gs}��I���i��/r�f���<��.�lنvE�^lrhs:o;��"]=Ls�)�&��?��=<ɓ6���Ο�~��=<����j�9��Zz�^A͍,�Lʡu�gg���K^�\k�<���Q%���v*w~�<�t�l-(��C	���4o]�����E�Ӣ>z6"�TR
��J{������rZi��J��������S�������L����8�]���bT���t�;���G��_'9,3�4g�y�Ȗ-kߌ���i�l��;�%r��������l�b�^�s��I�y�y��ݴ!��7єB.� �RV�+�'�&
�@���	k$v���ixw�-K�n����Q���"7��`���Ayd7��{|1�����%{r�F��G�~z0��x  ��,�E�\{��Qq�D.^�Z�Ѕ�d�]V����G��+ҁ�	!��W���"P�ȱ&'�I�ΪpXr
�6�Ϛx���K2�
���y鴱V:�E� !�H��h�	`mꨡy@��N�r�"p)����`��L>���M�"r�	��<�@�ޣ��E�Y6$y�f�\5���+�2n�;^��@&����p� tG�~ �K�C�S<��N���p,���B��=���M�-
8faQ!�V�������@�J!R:�Ƣ�e��(�, ����ۺ0�M6�}\�q���8�pt�����ji��>�����pO!c�/@)����]!�$9��I�Z���H�1D4��DY�.g�U ��p�Z*nǸ#�;{h�
$"OH�Rz�1^���䵒���	�DZ��J�A0����1{,�o�SG�AqN�����f�����/+c����:c6��6�߸���K:֜xCiϦ.��s�2�VFL�]8�-_��M2h���	��x*h��򶠆a7�;-�+Q��Y6^�p+�q �R$O�=m�+��\�}W'�-��R��-	�����Pb�D|�V��By[��
�ܾiG�h��c*����u��)���l3~��DG�_�$
%iL��7fm�SL��$j��6:+	$2��^sG�^���,�� j2�d�����|�0������2�i-����	����v���M���f��L۝!� �D��[s�i�z�	�Us�������d�a      �   �  x��X�nG��+��܃��$KN"G&m�v�\��^���!334 ��TsI�k��B�����^�*�bp��j�.�!���q����6!6-zX���d�Rl.�	���z���x=���I���s�u.O�����d:��,�y������,\]w���w���q�}U�����N�e�j5��:U�$n��l7�泰m���yta\�q��uմޚ�5��Y�j�Z�7'{�^�^�zz��d
��RbB�����	��LSu�Ǩ烴A��h�l9-�c�6��NFu�KOZ8l��[
�tiE�y]J.�)NB9,�a�Y��)Hob�y���>���'}�jW�_���,�}��)F��NB,C.���8 ��l1���4|�M�2p��m�@d4j\�B
�9\����BOb�U!���f����B�7F� �[�A��DK_'ᰤPd�y�(����p���^2�޾�����}36K�0����#*�\�%-�UV��DT�)�KS(��./����d��d�e��[�g�Ђ���m��1��uhQ�6����&�Ҽ�M�e���P �M =�@��/�,}r�Ȝ����1�
ո��T�ؓ���1lv���l8����l�·h0�z1��G�Q22ĲdH��C
�򦴁
�ʔ�K��$�)�J��H&b��D����Iw��C��[<�,Ӻ�w��$Fo_0Ϯ	��Ϟ~�L��)�T""�g���|��>�d���Z�і� �V�P��PGP��#��
@�b�"�;e	v�Q��.)׋$�Ah�(�),b��!���|���_�;?q׉�2Xjp�l?F�7�:܀w%�f��j���W�����`�7�n�����]@X��l0l)��n6��:@��v��o���~s����Y�S)�n��}�Z��ef�eW�g-����H��5FY��q Y�ńi/�OP�����}�jJ���jg�U]�?{E'�����b��X_�BJm��l!�>1ж��:��r���Ӎ��w�]z������Y3�P�����"�
��������~h��^r,��MÚ��bI	�$�#m�7���hCB'͹`������WW�o���@y7�sVF�o,�����/���
VA8�� �9b����m��
?�>�}���~�	�q l��]D�"q<x��C�      �   5  x���o�6���Wpރ[ ������zIk4��&��0y��ڒ'�	����H7��,X��-3 X�E��wO.N>]���r�V�bQ�������zh�Z躲���M�Qo�B3��c��M��D�]w��9Xu�&��Fo���/Д����5���fZ-�
.:ۭ�6�l��q�v��.Ә�ڕK��� �]�?�R����?�Q�hWu�B�}�}>�@o�ޱ ��ز � ǰQLaQI��2�?F}�-�-��2`��V���܇"�@mj���y�u���h�?\�y:�Ӱ���-��K�0�	�T"Jr�s�Z+c���a��9�9W͉a2y��W�^�z,͹۬ =|����n�a	mkg[��lh��ץ���Z���y�l�h�o��K�����V_�G=n��#�%�Ϗn�n����~_�s�939����� ��
e��]YW��� �E=@c4�׀��C�P��k�'=4����=���H���K0@�ʣD[l��1�޷��o�t�F����xt�~������x����+�=4��f�D� l��u4-���Pĳ�.%�U(����Y���X-�zm⫩����/�'u��?����5e����x��Q�{�%O�|K�n�����w&W/�&�~��$��u��e\Z���NHǷzA.i�l��;nW�����`4S���h����]��q�'�v1d#��=^���JLA�:��RX	i�lV������qF��uSv�����$�'��<�����,�S��	��b:�'��!�J)2ۤd
�9�(&$RI��
�X��e�
"^L��M	�ʤ|�{��@竦�se��,fB�a���B������ �i!� �l̝�a�9�����(4�W��c9���A�hP̍\Ǣ0�)���xm��,:�L�x�|�x
�C̐��BcA��&��RZ�,�����Q�u�b#��<�LG�3��D��'ϩΙd��w^��A��R��)$e��<����A:����H�Kʘ�
:P�b[�2+^�f��؅�O��)c���J��_���h�\��D��:t>����/�>ZU      �   �  x��VMs�6��W`xq2#� ��{r7Ռ-;��K��Y �-E*�������Xq�d|�x��"�o�Ɠ���)O��d��e��p?ê�8����C��_�W��d�����~�c��H3�,�#�F��KpxS��������h��BYxh���\���T��?-��?K�&n��Ah��ۖs�^�G��O�ȫ�L%�cT��T� (�<P�AY�4���~���	&)h�R鳌j��
!scg\d����I�L��-��Fh���{�����߶Y���h"�P�q�9�����4=�e���?@_��	9>��~:>��7�dr>�c<y����MN P�FANe�չD�5Zm|!u�k0��G�h�=�.3��Tp@ǍB�ug7o��"~�[_as[8$[��螲��%���}�!��K��!.��鄜ն(1�*�_�~�8k��aD�̏����S�'�o����N�z��YԘ���PԬ�]���	�R��Ks��H��<���xs���EQsy�,gv$�H��'U�������b�H����Y/��2��:tW�S"^Sɜ�R���2���`X�&e����`EN�C5hF�^��3�w���=C���w�d�*fp��g���SB
�Y<,�e�{�� ���2�������s�F�N~���L����U���ޣj�5�����R��z��,*��m�������NZ3MNz-٨��=Ԍ�Oˎ���t���U��<�y��j�J!8���8sd���1�ڐ�����D�d�ʨ)��X��:+/�$'�+�UP�6=D���g+�`��,�ԭН��9H�XL�)�`�U�R���H��^2�s��j{��J���wWe5VN���3ϊ*j9�<�s�?jɍ�ktW�t�"hGm���ܒ�v��t�K��ڽ�b�"z��#�v�?�RzZT}GT�ĥC��d�`��a�����3      �   �  x�͓�n�0E���A6J � )�������DJ5[�/�D�G%9��>d�&]��6+ν� GG3y�x�PA^T%�;�uz��}c�i���gg6Ӿ�#�;��V6v	Nw������q�Ƶ�ܳ=����YOA�z3�xZ���y��sc��Y#f8G�Q�R��	���O��� ۱�C0�7��=���r��i�s�ph�ߝ���9��&D��$�q�b	�	�N�Pp]_n��
>�P�շ��z���:kU���63�ALs���
Q"�&"��d��:����n^�_I�wn�����ib�P&�1bs���aƄ��Պ��	)P&3�����`Y�Wb����LP����P�A��3`'A�"M��A����J�\���Z!V��,�HH�J+�aY<�{�U���`���<N�!�A�A�����V]\      �   �  x�ݗ[oSG�����$����4@J���&��jvw69�[�s�w�C��#�H!�,���svv����=�O��h2f�.M�<X����3l�e�6�1��ָ:*{�����<9_��p�~��i{�����`o*�B3]�p^!�X6s�e��g3|���|}x��f�(2�Z7.%M6�P��A���lߢA�:s�e�����u��K�����UJ�e�U͉�j5��:!AZI�*L��������?������{�a�!��;�Z
�ϧ�e��~#��i� ��{m|M��T��$O��R� ����##�t���2����:��S��r���Lڡ�C!V�`�5w���i��?b�{6����ل=��x�����O�~HR@kj����E4��4Fd�ĲI/�(� ��m����˵-�Ԥ��p.��-
`�X%��r��IA`�rm��|0��oX{��-�n1��YA��áj�J��¨(�H8��b���A��o�V�4 y5�1Aq���DF���~���["�פ<����xЩ�*�����٢�e,�F'�U�D��lM /���C9x���-<,��b_�U6cc�AC�P�ԚC�(v����6�Nq��e�:N!��rO�~�ӱ�Fʥ,����|і4�#�6�\���]J����J���'�|M1�m���/���a�l���E���9#�X�`�2���,�~�[>g � d�<h:0��)�!�쳎�2���%��n�C�Uk�fRo�ZZo���WМ5�)�bES����q�s磫AU�2|�R{Cmm��W�+�S�LB]�h�T�"笥0w/.-������i������s�t!�R��`��@�j�L�!}�e�����Iˊ��,��A:��$p�P
ĩ����q�o�ZS��_����R�+ē`��s��ċ�����!��>����߶�p��j��3���M%���\`�I��ָCƗծ��Fiߋnގ�Y��e�����ln7M9���Y[%�B�P��1�����q��B7��:�X뤰�[�om�ѡ��w�8S-�D����UG�)̷�M�ϭ��j:ǻu���H,��S�Nh���)��q`�6�]o����"���s�55
�X�� �.kL*Xs ��f#cDo�i��k[�\�@M[��V���P�t�Me�;X�f�E�6Km�������*3��e���Pa����s      �   `  x��VMs�6��W`xq2m� IP��V�F3���Zw:�Xʬ(�!���N�{��lYn��49�ӋD�]��{����.�?'����4kU�����+l�����zёץ�%lF䳬�0":ݖ�+m="Z:X��A�]Bݕ��+ٹ��`ܜlz@���]?X�!?�^��$����"Ot��I�P�C�d� �@���J���Z�ά�*d����],* w� r�j��m:+|�Fdvuz�p�I�0��c����0�"e����r>#��ه��dNޝ�����t��7���1���0��4��ɐY*�0�Lb��y��feU�[0�
���)��Y�+7��g���>p<$�����	n����J���	�y�G*W��"y�\K�yHi̊�B
ʗ����ڽ�r��qЭ�ƶ��Z�R6��P�U��.�r%���!�O򔻛]�?X���O���Xd4/�x3A#
$=�q�C!y� �Jh_��7��BocƓ�f"�cO��A�>��땂���X�/��M!���8X���5!�� S*r�h��zslL�w����@�ns���I�i�%?]��W��;���b-�� r) �[�ڮk�˝TV/�>9��������ߧ0�h�^xe'�硲��Բ"r��_Q]�'q��ԍ�̨<�a�E��2��Z��Y�H#}�.euhPw�R��v�ɾq���GGw`o`^w[:�^���)kn���^�=�[�\�G��]Tp��GL�iۚp{#]'��XHn7��z��w�Ʈ�Z���-�P:q4��q"y�N�<}9�\��X�A��iDC	 ��1n Mr�oV�.�֛�=W�~��zJ{N3l�4����� 4���Qg�b���ro�KD�����zR�!�rDʍ4<�����y�Ox'���9D����\�{7R�L�~|z{��iA�^����lC7����R�S�|Ӗ����,�Dv�7a�����>ͣ�>��}9�Ә
- 
�D1��	���o�.bQ���U�Q�M���i�¢�v,�Ϛ�k�'=͘�7�V�6�5�[�?���S��G�n�R8�5	ɇ������������;'��O��/rX=�}�i_��%s��      �   �  x��[�r\7v}�W�ҋg��.l`�;O�i��C%�<��%��Ĉds�MK�T�=�H*I�'�Lf1*I��8}.�ºl��������'��U>=)����.�}w�η��N6���w'���Am����q}�7�rs��tz�^��m�����{�z����*�m��w�L�]�]m����.մK8�\��kuo7�puQ߾9k�mz�~?�i�����~�5�V��I��Y��R�I����ı�����kM���]�.]q�QŪ�*�������8�q�����'\T.�+��+%�p��@�@֤jIY�KN��ҹ�H��Q���J��C��P�E�v9����f��rt��]�-�����YVZ{����yٜ]�g�|K����^n._<X���v��� �h��||��uP��Q��)R�3���4�+�tS^����||�ힷ�vu���e�6Ni�HOƬ5�-�|���Z����f���J����ӟ'@�b7���v�)�L/g�|�����t���᷏�N�O��'O=>��?|���6��ɝ�����Z�Ϭr&W}��-�}F%�Xi�Xp�VŠ -2����
q���X/QI/@5@3����Q���8�SP�qU�C�Z\�4�碝ד�go H��V�#c��ܾ8�������眨f�cX�G)-�@Ι�=�l��+o�u\ٵk ��^���Ys\;���6e���t^P��N7/�fL|0b���ԔmI6]@In`��l[3��!�)bc^{C�Qe
�R.%6��Is7�uJ�VB�U�Z]/��M.��L�g�Ra�*���T����֖��ѓ���YZZK�7�Z�������7�Ϛ
�*�9�N �uhj�Ov�h8
����Q�ނ� Q0Q��2�6�}o)�����J@�2�:�<��3�z�>7���A �c�!�
�ck�D��MP�/��pb�8�jN,n0��)[� �S�|�70��C��� �yv�|��h�&Z;�o����d;����iʧ�-�Mjʯ	�,�<�6��]n�����&*��)x&�D7�l0Q��A9�q�`\�B��i�Nv��J HR�	կ@�V�7��m��8,��V*` �f�{Ѧ�vm(b��fW��w��i�(�;d�k�����lK�%��:���i�7�:VN��?���\V>yPS�1�UU]&(�n��������H��*�@�A��������ԕFBQ�=A��01�V���g��WF0���#�pIZY�2Sl���~�X���������C6!O{<����#�a0����޾�Gvo�3K~j�xc�./>���H�V�mX��B��[ٯql��|�0�|�6ע�~� �F����wY��A&�fV)��E�Ae$������pt�
�L��lҪ���ʹ�.���f@K����6��\�V���tF�X�{��Fx�`�]Z��5([,��������@�foe�!��>��K�(G �c��Ѓ3�
�����%�2=�$6>�td����y�ۋ�@2A&���`��d�5 "�^���]���q�>��s���GS�\N������X!TE���W�Y!`5�j���-R�$<E�]���m��H5�,���8f0 $�����r̢*�I��Z�3j2ܵ1J��?�+�3U�ç���^� �:u���Вu15&�-�i��>�י�j&=���#ș�"��Y�}$���>wV���R���|���W״���5�B46���Z�x���z>W4��@Q���b�d)���<dMc0��A�mK��8�A�PhR�35�����a`�RR�Y����>��Ba�l����G`�����K�{��a�!n�~9�q�7�0�$����lv3�U�.�S��]�������=�TqK��6��g\I#��\!Y��#��a=�qq�&;]k<H�1IL���la[t�Ƴk�:�\���@yh%ZY�ǽ���d�]I%��(;
�p�����1�,{��ca��G�e�*�1�K�wSU�����#��K��5�K�F������V��V��^�-W(������Hq,p؁M��}��m�����{Xm	�x�mX>ˊ��Qge�)��ʲX۽��K�{��LV�� #:�mF���&	�]�f|@�\Wu�:Uo�4j�cdH�&'ړ����D���K4Z(��o��-��-�#Y�j��bn�%��
��=Tr�+3�HUq���U�.��2o�̡&���C�1 䲲�B����.���(���c�����~|s+���D����R��P���e��A�W��h�MH�f�j{u�eD阴�X��wA�Fl}\�ŲNB�Ɨ0�EWQ�?����j3�� 6��-����muY֬�c2�,���v��z�|z�ݏs�����TX,�d�v5���1mVV���k��e������b.��&c�>�0���Y1d�j�i��,�-"��V|tWZ�>>uUV�|��NN�we�"� A����ͭ~���˶��y��m'�3���%���(����x�i�v����:�z2��Ͽ0����S�'���ZD�	�1ѝ#���,4L-I�12Tr �'�M�PV��B!����ґX��H���w#a2�!SB鵳鎑cp6�D��e��nIZo� ߄Y�ׄ�$�).���Kk�V����L~A�U��c�U���YAT]w֌�su/6ｭJR��桖4
2��Ϛ1�Nj΅Rd������:B����mHANH ���� �fqP���st1+w+��U�G�$�"�"77�f���0Lh������d�#�q�U ��D��*t4"�� Ye�V#Lh(�	(kN��Ӧ �S����XI+����J4��c��	��� g�-�9HV���$�$�W΅�L���W�~�u�}��X���v���:X�W�ݣ�j��C�iTPb�2�V=������I�p�5�66Q��j�;�XR�:�π�7�KG�����buj���e�U\}.P�0�Sl����[ZxCq���=$84�W�pcs�U�#����y C�1�&ʧ�dr��*� ��[��۹�}��p���Rk>�ld�1�d�����2M��H��e3ʹՅ���+ӟ�[ܒj���/��,7��Ut6,���Jd4�XMO�2��o��4Ɨ�+g>3M���j,`E7v
�˪�z�u_�1��5`�<��;��C��rjI�]b����N�6��7z��9W��M|ob0�rXy7~�r��a��FQz]A����������ٵ�Q�~���NO7/[]O������r����?<��?~�O������Oß�����ɥ��g��ǋ��y���]�����~�����F�/bs�7^a"�XƱ�RSݚVT娱�Ne�7��6i�����
�)w+�ֲr�;�_j���o��a�7%T�U��,F�=)}�>6�Y�˾��C6�I�c�iT�!�t�b`���6�HN���jq��H�r\�2�菁U�7��LG�A�=��y�i::�?:�b�i�����!2�A<�}D]z��=\
��ζ+���]y,�ke���:��	"캓:�����0�
I6k_bi���(�sJّq9��
b�<KH�!�ם-Eÿ`�0U�r�:~4�j1�H�� �^�:�#���ƞ�,vMqmi% E߸B�v�ٿ^������rōmKA������1�>O(�I%���\���a���Q�X%-����(��E�:�G��:q5����>a���������3z<;
��ͭne���-^���h�	3      �   �  x�͗[Ka���ި�s�N�k�@I��ކ�V<�]����Z�������l�@��3�L&ӓ�/�n2=���������릺��U�\�|���e���~.��}��\U��:?l�������a�};�������\-�f~��]Vu]��Ϯn���f�0�^\��T�ξ�	)G���k��BX��GԀ�W%GP4&�ݝ=7��������ѩ{?s�����㻭�����Ūy�9��]�1'�Ă�����FT5?�T�1L2N^�8�?U: v(r��`�����g�����F�Ub��d�TTD�	�Zv�Pm�u�$� �qt�0�"QRY����jI����E�ٷ�<l;�zի��"�au"jz�H	8����S b�J�L��ƶ{�᝶��:�����s�i�vF%RH}�V��m�L	qOg�,�"�KK��*���*�`�o,��>�� ���wsl�!,B����!�qfn+���{0M�#Ǩ}�s�y9�R����@$�QmÁA��)Ӱ�hg���H�=z ���y�<��zMT�FR;0`JoF�!�-٧�@1�P� *p %5�Y ǌ���4I�";�m �`�%E�y�����C&m��ǴA�<��Y.�&�v� E⑍
e��Pm�u�2[�%_������?Ef�$����/v'�      �      x��ksǱ���W�TuJN�w=��[��-$lŲ�W�l'��jvwV�M�4HZRN�����eg��D���Đ-������tO_���''�OG�~=����fuy}�c:�}2k>]�yY]�}::�/ӧ�����~g矎�����X_��f����}:jR={ϮP8��׳���Lױ��[����7�Y��^b	�U�*=�NB����W��M���9��7�y:_셿_ҧ�$yϟ�oҼF96u[_̰����AC������$^�/���ٛ����uj��?_�ݼ\s6�o��5�����ٛ�Q^�,��t�_�w�uة�	8Iw5_̮�/�o�˟\����W��<�v���ɓ�'��5�XY6xY������5�*i]�(�������������}VW5}��Qz�G���$ildk�Zx��*�+�n-�����>���{o����_F�^\__^�����U��*�7z��v�>����3���������Y�n�q����5�-/ϟgW{���'���96����LSjH��k��x�Ct�O��ґf��i�s�v+�\�<kҜ��f��ߝ_~����
�GJ�E��Sz��{wt���+=x	^X)]pA�jƉ�OG�,��B(Nk%4�͏�>|���cS�Vh���~��Ry�
��jj�[�r�9(n.@/���R{)�Θ~�E?���󟸱�
;��F�4��E;]D�.�v��U�v�v�m�v}��.;��u���ym^�yM����u�U�m6�;���&��s���mvR�ǋ쬺���i���]~�����d�}�_�W�a�%���C�n��*ٷ��j}|%UvެٮO�K�����݈�}}����/;}#W�44.zl]얣�/�Q�^���}U�fq>��W�t����g
)F/g�8�����O7�yj��t�G��s�lPtЗ�����_hp����G��׏�LNG�_�}}�ŃG���O��O`�h[�jW(�*dd-�4��I�F�`�Fv���ǟ�<�~�AH͟���CV��lh��Z��U��jtH5�  ��ʷ{`�2V/YYu����<�9�qۖ�������U:�њ�G���{(�U�+�&��B-x�J�g��*���絼�p�7����۬x�sQ .�f��<CFxǠ���F(����:v���>R{������`F�@p�D���P"�T�IX�p��2���`@ٝ�#%	�C%	r&���V3���-�ח�rث����e���H �� 5�6�B
�n�2T�h{&�l�\�v
��O�xp�}��Uq����~I�/�<ݼ\�4��XY�(�h\�W��[I&���lEe��:��2�D�u�.$���{ ^��XN�����S���Χ �05'0Fsz���w��{��f�?/q��o����
�����k՚�C�Ić�4�J4sA/D�-ɥA\["��
C��Z��$2�K��0>�P$����b��U'i��3q��6FԾJ)5ڴ(�L�m�uqd�|N�p�;����ޓ3fWBeXj/��%���[�~�Cγ_�fY��8_���Yf��T��Z��=�b�ܓ3��B�b~�9귅~�C�K�K!K�ŕHǒ��e�:�d^	�]����?�������a��>@��}��q^m����>�0۶Qыz�����׏��z���jضw�������8�x~�b���Q��,ձ_����&&m��ǨFh'GGRE�c!�:��U�;�i�1��6>�>���<"/��j�P`�f�"�L!wb��DP4ͬt΁A�f�7�}���4��J�4G���^�D�-�O�C^C(-ҡV T �܆�X�����;�PG~�<�Sx��(p,���>������;Xn+c$���rb�HNk�[�9�JCNiR��F�g�ŒY���P,��P��1*z�E1���=$�`<Ǌ��/��8Ѧ��ߛˎ���!7��t-ru�~D�M��)n�jToa���<�t���఺��EO��ͮ_4�����ڬI�W��pX���������?����<��/F˭F�goF8�Q�����(�!�����jٛ���W��U~�i�j����F�-��{Q_ ����2W(����;��0W���=La��	�}O�`��+�u-%j�m���8$�"�6�qUS�H�)�<��>'+mj{V�HR8'cꈼ�-R�i[�i�
R�o�x�Y%��R']+w�yz5PN�<��j��R0v<�N�1�lR��D����&H��=蟪���wy5����.=�j3a�c�]@S�t��9�d���x���F)=�#�ܶ�i��T��^��m��*��Ƒ�?�sFiWЃ"?�Yb{��d�%�kε��YC�Wb��;Ԯ�R���y6�5Jl.��7�g�Q'����&�8���y{�Kf���#qc�5��i�t�ê�t�h�؞;kLvZ���%7�CǱ����A��0ws@��G+@��ʺ0U�
p�*�K俱2ڔt�a��h]�=x��rG�qc&B��$z�#'J&����U�~��rV�pܰ�Ξ[ބ��X!���*��X� �0�
w<�Д�(Z��v�n�������QwtVo~bF�0�I���2���/2���Y�^?o.nF�^���)Gߑ�tv6:��Uit6��Y�s4�ތ�|�?��3c�`-�7��j�l�$KC�%<��{�������N��y��L��hvM�d�I����`���j*���_��B;qGUU�|sD��zjk+�#������L���բ_ϪE�������NBmՈ1�`��D7�D�	4f�]�q�I���pB������k�A��2�7��R�m��Co����+Q����+�|����'���&�B���*P\��>�$�`q��DM�1�p7KQl̸@[�d
x7. ���1�P��/-gJ�LJ[6�\h��e1wY 9���V���E�c\I��n�^R|�)�a�,��+_���y�wc.��d��%�	�2p��(Z����_
6�\(�Y�y�9^��v�㻦��nJ:{�y ��WZ��1=�.����p?|���� �� �T�&9��6Ee�.�Һ��b�ѝ~w�}�o��G�-4�Sz�tC%Z�J�iUi��~��*]�����}��	o���:���t��}���`(�����Ǣ�ұ���j,�9D��@�U�F��6E*��oL�c�F�\j�4!��oA����~n2�`-e|�̥$�&G�Ri.֍��^lg�;����Y�X���q2��}v^�6�w��Zf�Y9XQ'�TK�ͻf@-��L�=p n�C��9�����'����ϛs��L<��xYJ��Rq����"����Tu0��"��]@���҅O���UӍ�K�kaBv\\��̰��VX���VAg�o�R�T''��S_�͑�M5	�(�x�>N���k�u c��F�8S�態I9����h�*���=����=�u��ʊ��<4���oG�B�e�q  ol���v��F�#t������8*K�σ%�[��3�Qw�e�8�� Q�Ȭ����Q�Ȭс�dȳ�V�S�t�!2p��dmă�PN5�4�s<�w�7��A���t`5k�L���.�TV���y'�PE�_����-�NƯG��q�G��,.?7�5*��b����|Eñ/H���fh��: �N[�QpdS����
|8m /.t33�ws��������2�=hQ�[N�o�R��Z*꒏�}M!R�x)�6C��:�J�2ftA���;�����7g�4K��/�9�rtvquU�˻pr����ޛ�W����
��O�ϗ^�y�����_��\Ըcj�;�љ}���~�������o�A���׾M����!DW��m�-�"��� �z�ŝ.��Ӌ���i�O���>|=���)��ݏ��?^��ӫ|�$~:���>!�P�[*�ؕg��س������N���Z��~�\iC�n�� yS�*�#sS�����,�wT���묎�$TS}%�#���@#���P��ހ��A@�a4?)    e=�M(o:�Ў��A�;�a��	JJT�t���v%s
�;�S�z�J&�(sTN��[{n�r���!��m_�f&�?����Sn�r����D�eT浐+f�	�V��њ�f.�P[Fq���V.'
��{��iF���V2g'\jЧxzۀ��%���pT�J�u��B���)Br�pV���u�M����o�����=eq�*�Y,^��Ջ�u*����Z�O�mAN�D4��8M����� �L��c�+��������R%,�Բv ��LX�2? BG��5�2>�Y�z��]ȸ�ͽq�v4գe�TG�ٍ��2h/K�co���W�d�����.YT9v�����;\Uz��Y��g�)=Ʊ]sɛ�n9xc��'�|��'66�t�gzP��dg�b9z:S�f=ta���"���g)������.��+lgkb�⦬�]p�*���2�b��
'�2����i��K=`���ճ�.�=�v�r�T8���0���)�y��4�E�Ƿ���b}�u"�|1k�i��E;joΛ�r�$��t�+�u���t����Ϲ�����z�:3���;"���-�߂�������N�Z����8��⯡��Y��t�����?��ys��X�[�bZ@�+tc�i�J�5>�Q�q!�}���+5�����C{�jN�<�G� Z���Vೈ`�R�dQ[�0�{�_Mvg�٠T�Ó�S+ԏVI(@m�-V��;�J(�`|�y�~�JY�KP��)k��+���JG~6�bܵ�NSd�@��tޔ�z�1y�2T[Q��|S<��Y	��zk���w��j/"�Hf�Z� �`�U�>^Z�Ax+�}2�,X��Sf�Y�Xn�	��
��>�t�<J%�3�,輘ta~i����ܙ?��S�{c��jtg�X���#���׌N��'�fNX4����K���j�`�uvCs����Qp�-J �S϶���Jz@��G������+@�WH�X� -Z�読:��ߞt.��=}r:���oG�`ßs��T����������x]��b>���9����ˋ���'Ty����?\�Ʃ��	//>$"��np�C�x��v�HB	��*lU�¡Σ�ckB���{%��3�o3���#�X};{�s�{	�av�}��L�77����˳t����+
 �@��ԇl��Q��0KoC�R��u�:5�CU
�tJ�H�����/�i�yŷ��Dm�R�p֪����U U�
S7 �e�V��]g����b��T�F6'�����[5=0�Bl਱fluw�H)Tr}v�J�.P!x�z���J$v�^��1�U��&8���f���9:����0�WIRZ�%�{h3��G3J;4q���[ �g�U44�n����Qh�y��"��5�Q�Y����
N�U���{�WK����:��*�Zs�tH�N�w'��-���K��o�lQ�1?8��L��U�Q.=�~G�F%�(~�%�|Wj�Z	��a��N�����fL����XH$�U�1��a�F�TXw��L�0YT�6Ƅ"i%�j/B�����ʦԥ`�?zt������d��ҥs.���XBG�,��*h�L��m��X7U�3��XIS�fZ�؝@�cw*�����N�
��>�*�JDv�h֞z�)�<e ���r�1��v�YOLW�Ñ-,�:<�Nkf
vS��KJJ*U;�K��C:��{�U��9T��s�{�v�)�`ܚ������k�Z����,`������n��+@��֊�E}dP:�Zu@���z��n_I���堲=޷v�V"��ez焅_#����s�=����y�"[}��8�[ԕ�d�*됑��U��������R픬�:�����>v����������d����;\>��O�����?X
?�[��^�sѓ������ɝIE�gܯ��I�P]@�ʣ�.`�c�V��2ZP�w�V�AU����h+9�C�4Zn-�X�-5:O���ʳD���rB�P���]!")�1�h�n��xX@�h�s�n���Ұ��y�+* �؄�� D�@��u�m�j���W�y��f>:�;���8���p�QI�kT�+��T��5*��̨r��Q�>�;?����5�*���C�Ve~�U���h�w����Q���q��(uh,��u�v�,*��6&U7�݃GˏW�]W\}Uk�����O�����U�����?<uw�j������x��y��w��/���G-� �����ۋ5���]ްa�8T��� �W�F�
[+%�M�>_�G
ᔢ��L��D>A�.)�9*4����p�B���SZ�ݾ��-컲h�n&�l��v;ҳd�ξ��%��V7��P�39�J����BD۲��,Jyg'~��yY�cn�eQ�=;�%}�\�uFf7���=�Hɒ�Eu�ݽ���W�`%�,ķd~�/;���~n�b��l3�j�L�x���XRHs��:��;��E��h!]��("��E��%o�%ڍ8��c��{zOq0]q�_3F#}��!�+1�A� Ea�8Zi2n�۰~{c�	��̧RvQ?XzZ��z���G�����s�T�>��L%�d�-YH,�\����|�mAx��N�gQ�A�_�I2w�x�2F	�nE�ޱx-��:d)^���V�gǂ��dUT�����S;	�:�@��,�^fEv����{Y�;��n9	�g$o�V������jU�B!a��T�x_D�D�u2�Bb����b��pv�"��K���X*�F��(���d4h۴ʷ��)@�����������]��Q������b�\5��p�&2ɣfR!x��<�D��Vio��"��\�i�~B}Q`A�Fh��M���JYؘ�Fs�ʞ{��AD�����3�*�� ��XցG���`�T8�j���^"^�l�t�*4��9����UVl��!�G�Y����];ʫ���|wApՃ�~0E���O:������e�ց��d���%��������]���u���u�\�+T|1v�Mq�p�ڝD���C��R���;��Ug,���I��U|P;T�$;��� h��u��(�9�hĻ�1��taE]Pɶ���͗�i�$���:Y~v1[�ON���aHu��!�ڢ�_i[�F��J!U�N�U���Iu��d<����e!���k`�Y)M5ZY�_����h�{X�LӺ:��'�g;�p�ѶZ�J{������_�+��4�TB�Al.o�ny����%Z�fsB�vw��DG�9�n��uE�X�1]WrZH�@!��( Zч��@}�%p�2�!�q~�@�}s�9·���T�s����q��C��;����騻\�l*Ci��yp�,��!3�dn�R�r8?Ѧ�;�����?>�SS'�
]Բ�XY1�I�+��e����������,��Q�g�o�9\U"IGZ�b�cw�S�8g�o�@sx[�#�	��%�#v��l٩g{]�i'���:�l�V��G�'�$��Gi�p,KTv�W4V�28�*��<��(�"���O��ZXʕw��Bo�����6��
��}�����)%�N�a ŝ����ac�pi�#���[�G��ɽ.1���li����=+��<��h2lϳ�����9Υ��sgc��*�Q}�?�΅M����O.ʌ
�;���έ�c)���-�劇����+������v�U�v.o	�ˑ��U,�n���M���h��)W��n��J+4;\![p���բmAZ���LNN��>2�f��Kʒr+~���ۤ+��D�����vz��֜�cY�������a��c����������qu\��iS?=v�ڱʧ=ܔބ�魓���$���h8������*� ��� 1�����rgӁjm���߹�?K(Ak�+.TK��JyU�I,���)�U�Q�!_�5�?J+�r��(���%HAC�*K^��К3�);;/���!'�h�R��̠Hi_��;X"�/G
֗��NӴ�O?u��$��H��kTC�
XY]R���q����|�ج6��&�YuRZ �  y&_2��OJQ����Fɠ�TV�TKQ*�i�i�`v��Yf�T)�D٪Ly�R-�Պ�r��ka�35m�lJ���=?�}����S����,��c��e9���n%e�u+��ߩLJW�dQ��JE^\]�f-UPY���,�Y!�|���oZ�%�N���,G'x��N��;*f��WdG���ޏw�]��@w�m\El�,��PD!R�e�ZT�*�;7�W�G]�q�����2�S_��6��Th+��G �H54n[��_��P�ԻU�I���x���潌����u�W�����Z�N����C+k~�^J�.���HH]����,%c ��d����ê������1FRN<��&�Pc�猢R[�6K�RΌ[�rrCJ^8'��'e��q*� -���2%�[�
��Z9��*7�:#�JZ9@
*���b.`��-[Iɻ�PW��K�8n�JX�*�� ���CEpn�i�Wf�&��d�M�+���$�J�b;(���і��0�zѹ�ɨ!"�|��$79���ǘ�׈�}J��S3��
of�C��|Q�wJ��vPģ�,ف̿2pu0�hh�1�!z_4���\vQ������y�\�����\#�ԕ�����U���Q�z��E��=8��s�����P�T�Pb2NS�G��u-'����b��@��هʒc(��+�(�J9�%b�����*�E6(G���m�Uw�k�+�%��H7��p�3�-򖠫�He���"��$F��Z�ѕ�h-�`����*���K�}\��0X���m�%���;n��N��b7������8�b7�����خ8�z�����̍���*�םA�C�fu�X��"�=bq{Ņx`�� ��q\���qe�<���N��gk7�p��|[�Vl7\q�,�Yd�=�U�*jH8��T������tltG��N�������25���jϻ#0�����I���蜎�%�i]��sU��t�t�����}��ܳ�R��^U�wZ�v�ݶ���7�ǃ�;iCRr*��C�:�Qj���*��+�z
^,�ǡ�g�5gil���ٰ�����������63�L�x5�`3�$�-�yF���R:�L���j�AQ�%�!�w����-�'yӚ�>�䅅�v��Yd���ka5�d*` m�XK�y;�fJ��x>����-�j��bD����'�-
�2pe�˙�a⋉�7[7sT
J�����d
<�*Y�XRn��Wh����2��O�
&(nٻ�L)�%B�kz m�ݔt�`�eB�ƛP�@�:�H�;] �K�~�����Z�}*dM
|*4���[���Z�9�������s�&�kkK[��:��q)�A�vU[�Xk�T����1iae2S��7{."�����0IJ)me-�I�T� ����kb��oj�f��B�#$����m����4D
�D�Y����G�:��ʁYLXvT,�X�J*�0,1ԍS{c��nЙ��R&e��f���_iV���YΔ��٘Y�
$�٨��##�@���zh�*.|SS}.���3��x�2�fA:_+�Ј!��Zṹ��2n���]�-]��d��@ͥIС�.N���"�SY`�4��Gׁ������u����a�:��?ѝ���}g���Er�*`~�@�\y� �?̽j�FƶP��
�h�W����.V�s"�,��Hob-]�o��7JGZ��� ÀV�n����{��}���]��F��Ա��c�Bk��{�+��Vk�������;|r(�{(��ik�n�C��-��
���w-]t0���K����7m�BB�J�:J'���K��$]^��"�h�O�h����ԏ'hε*Zp�J�1��J�_��}���i~6��[�>v�a�uҀ���J��,㉣�%�"m�Q���U������� 4?��̯X���,�V��8�x�Í���TI�v�'���4�b/�3��d�j��@���apr��o��Œ?|����쭰��)$�Ñ�:_S�@��+|�R��C��Y��n��������U��f�lZћ���T�lppQmP�j��5��h�}L�K|�,�S���fЩ>�n����#�N�i�@p�c?��"��5���ewwEkS�굈Nre{�Î��!�D�.��6�5�:[NRY]���1Kn�Q|>OJZVnV7@Lw78���F�
B�jTad�qXv�_���3�r�r�j�'�3\�3\���z�CΐmJ���eH�aNe�n��ne���-}�힫Hɪܼ9�sY��ή�*΂̇%[ �������1�v�m�V©?�!��zsW5��3��v.�qџ�{�@ُO�Ƅ���.djl����65�o��ۮ�ͷ���jP˷nmUQ��:��i��ځk�
ԕ�xDek��b�ʺ���?S?��#���pB�1�~���㴕mtR�hw���dvCWexq��AKM���\��#�
��4�Uк�

 %i��uA|*�gVQIdeu�e��������*��n�����B�UL�أ�OZF
*!��Å�oC�Pv����Pz�%O�q4Wx �Ϣ��h��)nEtR:��)l\1!<������:�svq(Ar��tc5�PJ�5j �@�v�����϶wPq���S�@��3@�b)��uI�"��.7�<�P�`>n	��r6x��d�!��*c*�E�ΆV�hU�:fN�_vAI���:���,��5QE��U�t���$�Ku��l�#EI�:�=$-�X�~9��E�:��~(�j߳�Q^��
�:u�}��Za!�l��.i���q�t��޶0u�Z��K������K��8�4i-MA/��e)7���p0�C���2����#钮j�n��#K�����qDX7�J���b�v�*'�u�D�J/� ���i��$����|Ui4_l\&���._*Kę���ÅmS;�F���v������ttð3ϱ�B��:~�<���KnR۳�ٳ��5�^���Ylw\?:/g��q��>t^��jP�g���f�U�e`��*��_y@��MQ%�^x*�*��.��ѓ��t���� �� E�\m�:��&�>���*]I��6�����b��en�q��v0%��}�W�٣Wא��#xI؛N[r��`@H
�-|J�J�Ad�I˄s��x�e�6 ��˭k���u�h)0��<�`�`�XWhQ[J����G+�<�]�PY��Z����֩�Kt�B��D�>ly\m�;
�Ǹq�u��:��N� �m.G&��v.�=��Cks �����X��/�P�h\��X������(����¥'?������~��IR��4?�^i���`�����sE�>&�X��Ç���鯰�I��pQ�w����c��T��� �];qƑK����`�`U��A���(!E�±x��I�xs�*�?�&�d,��b'��N2���������      �   �  x�՗K��0���+�^v�֑gl��rZ�Z	
n~���6= �g���@��"�C��s�ğg<�L_=y9o&���Y����v���ֲ�6�����e3�#nu��ey���n��Y-���o[�.t��e�(]ȡ�Ҧ���n�q�η�7W/^?y�\�cIN���9
�#�����b,9�Z�/��ZC������s(�OEU�I�D�ʾ���!�x%t���@靑�Z���a+:���z����n�����ʹZ�?~��ŧQw�(����h܌P��9�1�1@� ߎ>�;��-5��{���M�G����G������'�g�&��5p�[r �'+��F82$|���1�tk�J�c�[w�ܚ�7��v���=B� 
�,r�Yh�w������4��z�iklI�^oj<hOG��� MT5L�s�I��F�C��Q'u�7É�ZB���@���h��!x�� �� +����D0�
2���t5'����+O��k��_yc*�%Փ'��C�f��Ui)\r�v}C�m�.;I�@��Յj��������ɓ��!x��IY؄��e.)���8I���i����`,徶@=������:B��-EΔ�����q�/�8[c�Y���� y
o4l\��
ڐ�)�~�C�).������s�t@R�h�ѧ������۾�T-����Q "8B��M%G�+
T)tE-|B/"XW�������u	{۫�x���n(����-�����/\��|      �   -  x���s�8���pQS���أO[��	1��d��+ٖ����? ����+�HB��n���ny�v��nI�_�L׹j_���3h�B�(2�f�/��ɹ�Sm1Kby��"�VIꟋlVSϕ��L� �~)���ս'�0��r)���f��C���"LeV۳z)3�oۿ�5�WIGxy�^I/��Q;n���Y��}�({�^�(rļ2�%E���ŧǭ��u�ϒb�W����u�8�"�~�r�X������<�������(o�8���X��q^��$���A�a<�N�H��BL��q�d.�4��fu/������ޟ���_N�(�����L'^�.�R�>�����yr���i(�P=�b������mxɼT��0� qB(aU����������8A�~}vy����Z��5n�=6�K�4�~:�wظ��2jp�B�~�j��2u��3����}j�y8i��jC��ֵ��SU��}���U^@TD\������-�,�J���M3�d�4�I��	��"�����:���!�1BH�^i{���!�l�{͑+�Bf�Z�L	6��R_��U.�bO�
�E�KmRҞb(�s�Z��t^��V�C�E�MP�k�E�����e�]���	B�w��8q(�^۪V�Ǧ��b��6TQ(�z$�����t}!�{��ɟ��Q�;8�Ë4�ו�~2�7[rY�ќ�M�r�6�x��*�E�I�i����_��QF��O�������9p:�ns���3�w��|����#�I,S���K��N�'t�������5O�[$s��&�3	ރj{�<J��<:k�f��������F`슛��ɧiQ��V���[u�3P<��]����E�+�_��iِ��40���Zbc@�#[�l=���ַl��HKbO��ub�3�9D�\N���d���"L�|�A�R�y�W8����>X�坃hqq{+_ױ{�oݢP�� q�h3���O��Ry�6޾��}g��в!7��9g;-�� �)��iP�-Zv�ʲqiQ�U����T�b��t� P�aR�G��zd�߃�̅�����T'Ԥ:�f�L_  �д-[燸J)R�c�a�q���F����l����;8�IgR��~���,.�����5f_eo�`9���X}�V�m��.Z��=@Vj#hcnp��h�ML �!=V�G��z$�[�Jʡ��
V�������ձ*�����
G"JRW�t��Z���b�Z�0�� 3��_۫ogp6�B�L�$�5����/Z=i�.)�C��]����p���]w��,O�f~q�M�X�l0ø�g�l>�1��t�y3^�&�U�k��`�E�C�!lnj��������wΜ�V1�)2'���Q��ⴍ��T'�+-.��`�sp��u��*����:Y�$(�U%��Z�+��Mߒ�Z��b���@��⾊�LZ����rQ�
]��j��oՆIT��l��JK���z��i̥4Y^��?�N�g�t'�N_�(�~4�4��*uN����r�p�a���r;uc���/������~Tm���vPo�Y��E�-u�b.���4yNS����e��l+�mB<�l�r�u��|q�/
lL��m�4Uܖ�z��dZ�=�l�������ǆ�)4('d�b��6e?�ѿJ��&�?��w6��9{��c�>��]��@B= ��	aHܓ:U�<��t-���/�Y�������-u20�^����u���k^4>y�[qG�8?�Gl��o�q�#�p���*���Ϟ�J�F��}��9�����4�ll�@e`����:�Xef�M��΋�:G���x��;��~��;i���      �      x��Y�Ǒ-���
�^�^���X=��=a�"B )�\�UH7hH����{�$�hdMevg����1	P���L?��xx���Ƀ�Oo}���緾�G�ۋr�c���������ҫ�~���^����w�~��?�����N5�N�~����^�z���|[�����O��UN?�'��{��o�]����W����;�=xr����]K�ZIYy��J�E9S��`{��o�~K��+�����o�y�O�����U{��7����?ܾ���^�g����������+|r�?����~����^���
_��D���j물O]IbV��|��M?r�.~�q:�Q�{Q>��r�M%�	?Wj�e�̛�y���߼?���=��G�W��O���Z�o?��*Z7�%��Ֆm����x�}��3���7�b����������|}s�O�WJ*�����\,)�z(%�\�5���{�o����Q�o���m�΂�F�_?���[V���v�gNH���=u�ͨ�a��l�JS��
�]����b������ݺ����~z�����z���O>}�����}z�j�I�U`]���U�ު�7�'��r H�j����q9(��(jl��X��w}��lS�����3~�B�Jl2)�d|�K|LB�d�N&�����o�Q)�t��_�5 ��\�k�b��d��-i%&;�F��^��)�4 E���m�{��ϧ������-����c�ـ�J��r��ڳ�Τ��|���M"*V)���h(⽒�ԜV������Q�ȸ�M���g%�;��c����BT�(h]�R�M�������s�֚�\QK�]Q���Q&��4�^DY�4Rw�<�IH�*�Ͱ�z�$�@�'�o3�!���x���N��@U��Q��/|�2��	��9&P?���U�D`ѾSg'����4M	�B[�t9�8�V)!]�Ƭ{0��+��3�w�F٨�~rr*���Zm�0�^Ow���{=|�O��?��^}����W?�0Ͽ���������y��a�, -��[�D�*�����MR�
��b]���:�8���3 �x��Y|j� �O�n7�З�T�3w��C��:&k�N|�tA���d ע)n"�p�Z���]�=����c�#��kT��ڎ���"�7х|�EG��rC�vJMa��h����jm�����F�-+�[O������o#�+-3��v��k�}�oy�<ٔl��%� �ǵ�B�!H�f
�?���m"*$K��2R�򆽒P���H��}��w'PmTBo��w@�9�A�*���I�
zg�U�x+۝)�}�K@ubx�c�'�a���K��^E�n�2��5�.��U0o�U�����l܄�qȊ"	��RWL�����>����G/�=����<��}�Wz���/���믞>I��^=��/��W��N��{�+P�Ǎ 27w�n7w�ܭ�	�q�y�BK)����;R�M�&��!E����ϼJn���:࡯�U.�ͣ;O?}���n����"`,1a90�Gvdց���.NY������ڤ�^��lV��x�<^�%$	�t��Ð������ph���5��#���݁�
�+~$��ON7�K��аN*y�����dT��N{j6�:_ѱ+ѥ�P�����������e��b�#?N�?��峸�.-�p%����;p#!�($G�ì�/?}�I���D�攴2�5=z����e����A��	:ہ�8?�r���^n:Քf^�����TcRB\4����I�oG��0]����Զ*ҹ6�����-`h�
�5�?ZZ�;��M���?b�p�4k5Ri7�Z�ԋ�i�h�6���g�%s�%�*���c|0s���Mt
7�:�C�a���0��J�K���0/8�dnB��<4�ޣq%*�"� ꠸YF��!W�{��k	.��̚�ޮ*�XM����^w|�ý�9������(�Yg��e��S0�2�s4Kgi����{��2!-��k�G9%Ma]K�o$�8�K͞��H�3mI�8Hw�=����Mf�&A����;:�)����u�)�W]��N�Z� Gz'a�^�ew���g�5��O�-f5�l�R��$�;%J���nh�c���"�-�K�Tv%���欁�� ze�&l�Ԛ��a��ϣ�h��a�<]; EY@|lto����̳�r= 9(�2�k��*�Ы��[Zb�P<V����N�͆f)�G�t~oRG:����Pb��F2a��8�>=��9�I�;5<j����%m�8��7���	��o?�5��ޕ~/�u�{s�{�Q!]�>XF�Y� 7h�«�V��|Cze܎����m�2y���r^��}��S	-oS�.%�;�y�=#�����]b�Z�A�7w�}��#JzmgՅ�����&�d��i�j��Wa�94U`�p����~���5��(�W��"�9��x�IrhWt�ZaҹHp]�}�|�'�>��}vC�ܓ�|�_���E��&gY:�H����Jvz�����\�)��:�*�?��>��e��?~�����g��C�������×�zY�|��+���pY��|ǫ�c tRjmT"M4U��c;T�Z4]5���#�sO[���H�ƶz�����uR�s�Ju���#չ���!�Ǭ6�gO�o�ĘR,x3M` U�"H��˻�o�Oѷ�ª1R-~#*��˩�v�[�B�W����Ӌ��?_���ߟ4��w��}�t��GB�}�/��K,\)*�gᲨ�S�qҥी�$��B��.���,*&��DL!k8;*��>�&�u�9�Բ��,�%��7wGTA�� `yVO��6���MN�0�����D��:t���O.9�
�����Z�̙Y�6;c�K�x������މ�����a�q�uӽ�Ӭ�f�3߮͞T�{��~&����,�K�\����M��YIc�I��Z���ƫ'*�����>� h�h�@ҩ"׮��j��Rw��3ЬC��}>�����n�pf��y�<�d���D�	���0V!T����`���Nǹ;���?�y�N�����2��q.�Kd�`>�q?�"�Uf#�f���q*�\$d��=f��pP>�t�AG�5L��.�����s�F��bC��������\�S-1w-�����҉1�ޯT��s�ɳG�nT�!=�.��0�kv*!�(�xV,�i��9��K'��W�&�,�K��'c��%R瞏�aΥ���M'��ǢRݦ�|��x\��(�&�n�z��1���frӽ�/!|(��E؁ǫ��(O��P��A�A���������\5'�[<h��8��To��r���ZP�MKO�6W�����)�e2�ؔ�v�Y����tGV����~(E -=�Ľ;�m�r��4�:�U����+�n�����Nn0-���M,yx�;�%w��-9�*�|/%�a��(�(��zK�܇�ہ6O�m�� M�|0���V�ނ-�q�4�]n#;���Se��8;�L��yO�������JJU9�u��L��~��J��.���Z�)I�ʜEU�\��@�'�����vP��uP��MMG��Dc��*%m��*���)�P�,r�ܭ��F}-j��xt���Y���z�J�ο5��bF��- �����{%���J�lK}TR�JA�r����ō�9sE۱,�.�71��N����`�o/V�hO(�ۖ�)��C��h����J\����"�K��5`�ϧ��wXmQ�n�XkQ��m�P�q:�S�7�ʹg�W��6��%[)*��jBV�j�++�Dq֛��s�J��ؘ���&1�L���P�`�XJ|(D	�m�)�o��sWA�:�m�����(�^QK�]Q��;�(�i�⢙�?}�̓�Z��T��n����Y+B���@��f����)6l�4�����VA��-b��n~�P���ɓ�@:Vφ��~>Ȥ��N�o��Z'vG:if�(y��f֊��&ͼ%���NEIv�ͬ�}��f'�P�$�T�rܣ!LR֪f��    �fݮކ�|��I�<f��$p$�>y�ފv:+��6��M�ŋj�f�;Q-d�K.^������Zl~�=�w@���hr E�u'b��L[w�)
�>Y3�1�Gu�����C"n�4�کb�8Y4��I*�g�݌�a��T�Hq�C<����[����k����R�:����7w����ӽ���6t�'�T,�"�w5���D�E�����1�o�>Y�X�Tc+�"95i(�UR����ݪS7ll�ۤe��`ӻ�ڌz�h���E������tGG+O*(�˰�p���m�=<>�$�Ti(cX:�� �+�U���3�wޝAV:�+࡫1�Sz�vz"m�SFo{��m�g�@�U��j~�$�bU<��/.�Ge��%�B�ZO�C�PHh;Z"����P��U��T��$-_�3x�:.f�f�Ma���)�Rg3`-*i��mj'�:�;X���ڞ�V]�y�Ә>%o`���sθ�ܵP���Ө����<g�G^f�h�ӝGw6��D�%',&���!%���ڪթ$S���4��4��4�v�ClY��i��غ��mM��!��e�B�m��s**Y�r�"�Q�[>Ƚ�S�i�U�&��
��<��"S	�#�t�W8�ԢGt� �B��g���l5
:���Aa9�J.:Ճ��1W{�f�d��S����6�z�Z���9G�l�2-�t��8{[:#��즛)�Y��wQ����7	$$𜩌q�!���|��2:y�R"H�����6�%�L|Do¬+���RΝ��KH�pGOJ��J�r�Y�:WN����+Uu\��>u%	R�V��i ��`�E�&�d";���qj���c���)vK��MK�]�{loswi=;��P5���=v��?}�ITQ���1���
������k��;����Eՠ��4�t�P�i��IӸhp�U:Bsp,El�512���f�wcZ5��E�"KW�P�[:�� ��NL>�ȁn��WϷy��G�^��M۩'��Djԕ��V���)3���̻�Fm$�b<	�nK��6F����� �BѴ+��1���1�d��w�ν��Z�6�b��5H�E�%������t�"r	Oo�����s����~��6�:t�˸�3����۸Ooϛ2#��]��ƚ�NH�*��ک����ܼn����B���RS�*� ���&s�v�%J"f߃HW������\KW)���l5ӑ
'�>jGV5c+�S00��
	_��S�T��p:�ر�*�,_��v��g�?~.�B�p0W�Z�Ԇ4A{��X��Y|/�N� ��aX�v
��ශ�HR�E9b�=����:Oa7�{�|�����EB R-� H��H�)����#����I�������
��6c��+�����l��_o̘y�s�c�x�ƫr~�0!!>h��U#�C�8�^<�(�/���_��m�gieި���Զ�IZ�+e��ƊB��j���4��.�TK"�A�� �ڔda�`������l�1Ó[���Qw�/�)�d�+��i���C���6d}���>�	b>"ş#���h6v��N�ps1�T#{��z�C�,���i�����Sȥ=��,���b�S��Q4q�:np��YG�[-�%HYN㞆�c����4(P$~���xfn�:q�p3��t�c����vgDNfM��*7�|ɢ8$�P+-j��vL$6����,����3�X�K�p�`������B�HuPG���(^$��1$��}=n�s��m�-w�a¼UL���@����D��p�1n��Y���GLg������4KǳȣnV��MU���/��
�<+f?�����������}�v��k'�?��@�|�Nj�r�ʹ��# ��E�p̠;q3�`���~cH\(Dh㈘�D�����MlT\�����Zg��Z��Ҙ�`G9&�w�K $�u-}HE1�m�mg�v��mlo}���Y.V�d{@���ʗ>�5���D:5Sh˝ՙJ��U�jϯ�g�rϊ���BYy��,���1�1@�Dcyw���3/P�\u~�DI�4�,�U^�'�w"U�6&k��R��;����K�9�G��$)��P �I�
l�⛋���ȭ���ܸ��?S��ƒ���"�V�=�y���G�.�wW��z�(���=|��=�B<����!�m�E��쎴3�)�/ �v�� )�D�W�]ӛ�� )�Z�cD;k�H��k�)esK��;4��mkn{3��{�3�����81��!���Qb9.��H���4Uh��/:?��$���>zK���6�ͮ�(��Z�sւ�Y<5�<;����R�*B�A�oc[i�ǌA��ֱA���M���l5܇�Ϳ3����k�r2H���������ܙ�ffs���_m��se�w����ְ,c?A`�C�5���tȘ�!N��+�j���w��i��U9�=yts��s�½�>�����g���G�᫟^��_����������e#%�X��V�=,܁�w}E����	d�Ư?>٦��*c�4�"���~�-�)��s	�y�l��/��'���H�`�L��t��_]_�n�|���ß^<��S�ݗ�g_��������q����o�2�,�p%��a�4nH0��ۜp=k]�ݧ��M1Qt�N�)� rPT&���j�]7�|��|�B����8z˳p��|ӻ@�G=��y���(Pի	�Z�eW��R�S��L�1��ɫ�2�f6+o:m�:�x-�x��R�1"!%�b%��SNK���B�+x�����8
Jͦ0]Yòn&����������DG?��G~��~���gqn�X�n��p
7��0;��7sƗ�>�$n�ף��)2<:)3�q�
��Ry�ʦL9'�l:��M3l}�5�u����2GQ`��3Z���9YMn�v�1��Ω�|Ț�~ze7|a��o����4M�|�Lu�q,�J"7ҡ�:���'q��Ŏ�_���b�>�~1NԜv]!"�[=*��T%Z��f�aѴ��H�ٕ�G��8�/+�hB�%Sk��-?����\�,1a���4r�p�0�]�������������@N��ņ�/Y%Kc���@B������˳+���T�����U��$�#�P)31�R��M�O��BE�r�zi���ý�,\x��/�����8�V9TM�iK4o �ʩ1g^��j	i�|F���,�����,�M�����v�Ɏ.Y��l���lM�كoxk���Y��� 	�i�k�vte2��(����&ɡ�+t����w]A���`+ތ|� =�U��s���60���{R{�g���o���~]&<�Xڭ�X��>.e��X!�k����	q~��Ύ�� .�@��!m�ؠ>ts-�,�T�W%V��ԤB37t�Jb�� �"^�G�|��}�?}����������!��ɿ����Kz�,.�0")�C,����	f���s좮ٚ��7`�;�c�TW��1���QpE��%��c��5s�Y1H�&v	\mk��d-(��1�Ab1��3��k��\b�Z�b�7wjV̘�d��<�Y1�L���Žg�<{r����!{Q6�f ��V�7�&<Rs�;�	H��Ai�	 �13��1��(>���[���\D>�2��zt�Ul���B w��[��쨱�1���:s!89���n��j�-�ج����Ζ`b���:*�D�ZK�ͭD/�h��J�����E/�t��Z�b�>�K�"��Qt��xQ��A/�9AH[r�<��>n�h��Ҍncr1��珢;�J� u�+�ׂԲ�ؗ!e)8=���Ԝ���vWb���"��SU�cO���Um9�=�7x�ʊ\*�,L���o=+f����h�J*^k���o?�5���J��:��p�z��D�t��`i_d�JgY�p��99ߔ*G	�)8�ܮLޥ����Z�=��B�6��R�#��ڡ��͖ r�9��]k����Nϛ�q�׃��Y�;����B ̌��*يw���{IU獅��۞߬�Q�ȸ�{�Џ�!��
�t(m�#    w�h-�{!
ɧH燀��w1��8~���vD-1w-�;���d�{8'ф9��Ν�6	��@�G�1�8ڈD�����2�i%�>���E�c:c�^��K&Qk�]��8���,w��`��iwG�%vF�<��YG�D0�e�c��k��ͲtY�,Ř�=^Ra��Q)�B�L�_ށ l0`�"��$
�:{];�Q��.L%]#R.1w�H����"%��NFJ�f�)~��MF�1��;Ѫx�G=����j�m�q��#咳���V���`�����"�ľ#j؈���xT2����"Zğ	K��E�-V����A���$�Y��|����|d]�q��̸���ֆ�4�@5w�Խ��6!8�l��i���� ���/�����$�t���׏��=m��(:���}rֺ���K���Ϭ]��*�d��Ԩy�3�	��)s�{�io[{�,Ea���B]L����s�]��
��@@�T'6V1�}I�;\�-Ti�-T-��_BU�&N�*B���f����f �3���@	R.��+w����0IC�V=�5R��2��\k]�K�+���BThх|�EG";<978�ϵ�Pj�h�N��s�B����@s�IDq|��f_D}�x�Y��VT��!�����THQ"w/w���t�:ajۘ��vT"nV��VA�<�sMQ��������%m�(8�̨�S8���V:�TJ�:�>���Z��GZ^�<�Hk�k�G/�	���ȒqW漺1����ì���	G�RuC��u̵�ql�/�.�k�i�ʎa.�q��Z5����Y�&|��;kq�#��Y�S.��y�S��P3�3�Sn�uǍK�	8 R��'}�xϵ.�I�1��7�kE���kE�#唫��'�\��ea���H�4�(iy	�D��rJ<�d��LN�G#��`ӹpm��vj�Vs2�ֈ�v,�FP��[Nd��9�k�Iݴ���rh:�Mc\E��'#�M��-��,])L�o���M��/��tӌ-Ps�t��g�lmx�%:�ȝW�����$�Ji�ο�4H5d<U�h���ۥCQ�L���:ʵ�T:�K�kM�\����^����B�,���ҕ����;.Bk�8yl9���98����M��vg�̐dc�ei��J�-X�������	I�E��4����gWnJ�c|��Fڀj����0���"	c�n�2<&Ǧ��~G��+w:�L��ġ��CH����Z�����\C0-1w-����ӂI�%������ժ���M�
9�:N*���a�*�fU4�I%�0���bm�\���:��SW���Zu>Z��`%��uDh��q.¶Q'�@��%���xXb�j {��QD�L#�;�Y���?ms#�w�Wg�j>�81��k�|��ı0O�P�mT9�d[�#Cf�lUAR��CǪ)�p��"��Ĕ�x��f��l6�Q&���"�Vg����WC���w��U�8�f3diK���.��~�L7�#W���ո�Eu��v�^������7yر<��9�x�Ӻ�,�Yu�O?�$,Y<ߡv�PK?�S|�\��J;��7M�N088���� �� `�$�ƣE�	Ru�1��#3�KL5j&L-��v
���ULV)IU�3<_��t(���n��Bg��6\��#5�U�v6��י	��ܵ�����@��ZOW�i�)���;_m�Jmu���q�|J1��S�MBl&��x�%r��N��P#*A�*gj'�:�;؅j�C�=[�9VWz������HC,�K�]�B�s�����T#QO�Ԭ@RΪ���Σ;�DU�:�b�c���ձ���b��� ���d�"��	��ű��G8J���O<��9AV�І�3n7h��)�șm\&�Y������]m=z��׃��JNϞ~�I9߹:p�X�XYFcn+*�	"�muG;��^�.߼x5�5�HD
�|laLFqBصZ8�����d=F�~���3�T-�4�t�xro̘�r?�A^-]�^�� a�ݹ-%Cxجob��e �q��`�,~��Vz�)D�J�x��t�~dǂ�竱ဧ3'ѳq�܎әh�"���E7k{B�gc��JK�F&��ߪ�$Y��	�nK�+���=% "�g-R(�vŻ֣g�� ����K�ÿ�N�oc(���J��,�t5z���;Nf��2]��aֹ̝�_|�M���V]�)�B7b�ʅ�
(���݅��<�<Ai�P� b�xb�y6&-(F�c1Ds�R��vNN�er�W�-�]m�s�K 2>¿2|��`�h9͓�=Z�.�}��RC��A�X�]R���S�[b�j��6w���HO����,���oQcG$���FǨs�c� bd���R���	T����(H��f����JwC�t���U����s�J�lGvC�Z��NU��ʱ�ߑX�xVw�V�r��l�y5f�*��Rx -%�\���h���79��[�����j��l4|jb���3t/��V`����=�U��}��Yd�Z�goK�a$���8��Y���?�f:Ɏ�H"��X1F![GM6��)!�д]4����@v�I�v��MuݑUΌ��7�c%�#�c��MMG��r��$���0��U*ق���𖪹��}$e�h�RǛ�t��J&7�Ҡս�Z�!�4����&���(�������^��	ͷ�@6C1u\�M
��+'�F��^6%#������"�J����qËF�����3/nCU�Z!$�}��Ґh"��z)�Õ� ���<�D����R�E&C:��yi�2>&̻���g���ᷯi}��H�u���0Y,o����]�f;ot��m^^��u�e��t����Q�T'�h_[r�k�%��wsm�%�Ko���F���.��տ������\#�\)XU�'�Ub��P$�j8�u�Sg��;��'����f�!�f�����D����Xx;�wQ-���)� ׯ�Z���Z����g�<����j ��<8G�t��Ko���jW8��5y��t>���^;7ݺc(�j&����Zz�l`Q��
/M�q{�6�(�(�;My���7c��1:Qf��nu�[�U�rx�GBl\PF�uT[[Y�8�Tw;�[v�S�A<e�y�V�n6P�&uey,�����ӻ��m8�9-�8-�8-�8¥6Hر4��y#+6�4�Y��9*�:JƵV$&�c�o^V��� ���GorrU��X&#؃�z�{�eU�>�єЌ)�``.w�0��=�� {������{�4y��L�1�9��la��(NsUks�+�E:�dcԔh����>DT���V�K�Cm��� Y�ekcj_ !N)jU
��Wּ��qɭ��Z���~�j-Y�G��%�d/�T��%�.s�����%��[�*H��[Tl &0s1�a����2�tv%� �9�p���Ҳ�&[2t��ҭ�L{]:�ݸ�Ą�(�Yz�#q(j��|:��G����LR�,�v���M:*�kc2�i�^�Uوi�B��hL�A2�-R�9P�2�m�b��\ص1���I&I���@��5cGI�j�aP���-A�ҡ3I �n{s杷W�����
���Hb��8��4����4U��/F�n8� k� �]�x..�Cތ@fۘ�)y	�^��<,E�,�!���"�]���h��Ю�Vp��s"8�Q��59�6����=������_z���=���f�����/���>~�H������q1,���%jK���T�elrt	q#5 )�N�H�j.ӫ��`jvО��+�|fF��)��L�&�E1��������
	פe]�#M-��,-Yb�Zzus�9v�΅I���(��!Ϟ����P��x��j�vղuEvVo�er>� ���A���8�tI�<�+qc-�j�ۏtM����J��:�=Y�w�O{>�B��}��e,�t%�:�҅띬���6����mR8ھmkָT��ɬ)�%�S	-�D�]J��\z�H=F��l�?|��N�]+R�o�H���h͉�_nu �M�P�r���\L����R��4�AN��    
��wR�V�<ғ���䑞ԯ&���_
�� 7y����ݬ��fO�=N)1�6:)|i/��gb�&����|���1l��ˣM.�WD���
����]4�r�M�8v�|��~�twLs���W����z�Za���KPb��4��d.ZW���f/X���)>�ssz@���Gk[О\6���,r�֞���j���x�b'âg� 6[��F�)�+�a���a����`�dJ�Z����t��/�3��g~a,���~��:��$��ܵ�>V V���5f+��a�Π�ۭ�<;�n��ig�b�g$�Ҋi���Q6N�I8��lu�n��w�O��y�����C�Bv�Ȅ3��Y�"2.p#��E�O��KG���+�{עi���uA���� ����Ͻ�q9���{���%�E��7w�\0oϊ��s�o}�L/v�,�;w��j(lY)Gn�P��X]���5����6I��7{dd�z=��6�f��e#k�&j��\�6Q#/&�:N��̚���~�J�����:R:8r��`�af֜��Y,��f�n�6</-mK1�X*�JnHJ��E5ɢ�1"��n�2�j+�q�?ȧ˯l�׍3�c�rE[�E�$�J��	�F���J��Fë�����k��%�E��7w��Eg��-n�P�����O�y��N����}�xR�*Id� ���1��F��/Y^���tW�Z�Z����|~R�⼦����VKv�(�~ܡ�Of��ӭ�ZH�e#?O��A�����3��nRuL0ի��������y$�7G��4�� �U���-�ʤCQ�
��:`m%sp,����8>֚}�%�!Vd���E������t���zzM�	N���WϷ�#2��h��L�a)��*7d([�մc�͒�S�|��r룛${���y��X�=H��ʽV��Q�T���n�L�"L����d��j%���׻ZIb��K��.�iH9vv����7{��KQ�z>�J*��UO�K`�L�1S��`�@u<�
��d�|��YE����|�$뮲	M��ʮ8լi��/��2���/t�~!��##ɘ7�D��v��b�c]��yŏ�Q�\�{R���P��0IKƪM�����ѵ�u3Nӡ�J{m��l��Dv�����!�k�
�H*K�]+��o\4�\���ͺ����m����9�Cʳ4�̥����B�� ����v+s��teΒ��˺��\9鎷�-˸QT�U��t!���67��Ӷ�k&+	x��HO�v_-5<�16�i��%R%d���.��-�����t��Z�Z���m@���O��� ���R[]tՍ+q]�-x�r��R7$��(�h��	T"���鮿@*��]��(�T�cwx�[�G���ki4Z��a:�u����-��T����r5��͚Ci��Ďѻ�u/�Xg��V����L��}��Zd�Z�{[:����<��qG�n�N����`�enØ_��[ݼʭ�ʉ���qf�������%�=_V���#��*N�ی*|��W�5�R�IMunc�NC�f��V],��x�~�9���G��S�����W_�����O/��/~|���߿���ʲ�K,L��)#ݖ1W=7QxaI���8�ZCl�c�Ĕ�1H\;�e�S��d֘�?>٦Z�i�&��د�G@DJ�>�m�М���A&�-��4�ϖ��_p.��|�࣑�����x�V'����Ɣ�:�@v�O�W�BSh������CZ���2�M%�W��@K�b�X�����1�-J� ��!��g�}E��)������M���@$�HpW��/��5Q��#&��͂�P�����j*��n ��.��~B��*�2��WP�p1��w*<�b\k
��|@��q��j��G"��TpSm��ʵ�)�xε�)]g<�/|/p�W�ؿ(m\���6;�Sr��-�� ƨ[�\/�6������=a�(�DƇ+�~Œ�����Kx+=�QB��)/>��W!��!�1Ɏ�O����`2�d�j4��Z¼ّ�-��D����`|�öLU2t�^T�>MJ����nR��������|l��:)U���1)�q�s�L��jͭp�������7/^��#V$"�F�O	~��SV��t��r��a�{�kU�G%9C�g����cέ�k�ߘ1s?�|38ې@��x�J��*��&���+n���h�O������ս_�t���=7�,Y��]j��Yf#�0��9=�U+��*��J�G��`�R�uV�RJu��t	Ȏ��9�u��4�]����ٱŴ
GlI���H�L^�c�6"�6"�6"�FD����eu1d��mg��9��8v�C^#B2�;2�jx���mxÇ;ʕ����Tm�)���۫� ���`�*Z7�%�1ACS#G�u��V�>�n��:�c����L���iT�'�w�m$f]�������$��ɜt8�P@.@���j�V��8�rO��b�b4�N�tZ���n�����t�E�*^y���
�^��sR	��Z��ۛȟ�|(�9�ߖ�$-����g��;/�l�����w�D�Q�*������{���!�?}���l� V�pɈ��G� &�XR/�Bo_���]o �,�y��BW�����T�D�o�&�KL���'*�t�%����8[̔Tms7�����`e����v��o�G!q��W�%��.�۷��ol75hx�|ϟͣ�t��D�3�-~1���sy������9���d���xO�}�w��1�\���z�.�Q�,]�GͲt���/�idU�CL�c(�%�X�rG*]�������'߽l���O?�������}�߼~򯿼|��^/;�Xb�Jۓ��pY�`4�T�WaM�$KBrt���=F�6���bb���6�$��ՠ)$��b\egZ��0�%�U2���%�'o��vަ�gO�o���hk�B���Ur�2"A�\B����rݴ�9��&z����
�nk�m�����S8[�yTz���O-�}Ñ88��	Fb���LM^��H'�u~���?wn[������mt"��Uj�Kт�w)
�XTI�pD(+z���~�J�:�]k!�:� ~F���:�DA�ͺV��U�HZR4�Ҙ�Ua`*4�)��r��_'PmTr�2į��7��w*<��������H�c�5<Qjy~�:�M��.��M��.�]�&��8"F8=��I����VoB���!x��n�0�^r��]������J��I(ykhVN�*�jd�w#J;ˀ��1(+tGnώ���"t����DR�}��xx
'�⫿�Ѳҕ�;�|��������_���?���ǯ�z�$}��{��[��|b��+]����挈��
$��͚0w��6q"�"��Rށx�.^��$ፆr~f��ݖ��]��cf3zr�J���`�:��ߜ�����>���׍����nq�Z�F'�\������G��p��G���W�t��7C68U�h�![��kPrZC�7Q�/P!v���ǵ�!��]���rKm�Fs�~�k2$�ݕ~/�u���p�m��GTH׻���E��Ԩ0�҅}�vL_�M�F�q���KR��
k�����Gݤ'��ƑMt)�1$����c��b�����/0w�C��͝>�F1��\�#��:��r���I�7�3�*�o���Ge�m�� )�ߦ;��d��Q�x�@*<��<�@a�p�+�`Vj�y�l��_|w�/�P�/���q�g���/��e�z��+���a�4�`2����8�ȼ��_~�h���J�7h:;�����L�z��]+��x���	:��N4t�*�/�a�`�!@�y�{��>�"�1m)
�)�8gЉ��'Iz̒�;�'W���f%��Jұz&ؐ�\DҨE���r��Q��8Z[�����ǎY�j��5�ã���f�P;��3�j�'Ւ/��"l��2�+�غ�����������R�9��әMo�j$��`YWCU���b�A:5S�͖��4�s�|k��"^�xe�+9ioص�sȢ�3�p�#�9��Z�s�IO���3'    mu�LH5DOq4��}V��#�I2�娫���=�I�:�9����p��$�gd �Z&ێ�X�`�Ճ4��N�=����Sɸ2�[5a,��hY�	9�_�8M4�y�Eѳ��V���0R��
 ��+Nx7I
�c�m9?��+C�D�6C֘�\��ķ�=�QӼ��[%k���}M�e\��x�64ד�6�k��v6
:�)�d�7b���S=���\핣��*��fN��B�8��C)�)i�9B�۸�b����*{[��b���~:J�FxN��γ��oKbS����!��i��Y���K^vm͸A,-��`k�������s��J'+AL�O��mmrE��r�C'l!��R���k���ֺ���\aj��ԤB�@�YI�m��9� ���3�&WDC�]F$��?�e�q�uD%]�5���8��
�7m;��w�0+��R�Z&�79�o���F�6��"�%�z�pr�$W]���
;��>3ó.U+��e�mn[:�"r��|�F��
���4�
�I-��ޏ��v'W@@y�F����6h e@�%��n��ì�^��f�������g�w�����s�������a~ţ�ctH0Ț�Nb��AX�����D4����>��薊W�#��7F��r�Ż�!L����^�G���x�u�?��("��\0|�ͳ/�6� �kƅ�1��Q�;��c�mDe��cت~B�Ѡj��4aU�b{��T�F�q,HEax�4��nuIfL�����Dh�����T�Yt"tϼ�P�)�x(���{cg�'B��^7����>$%&ɪYC��e7�"�a���T�>�%k������W�$V&�Ҙ�tq��/�6��bl�D2cE���mf�bs�#r�B�	K�ŒX=M缍�g��b	Ϫ�q�7hK$$%8��ԝO�H=��%��IG��l-�t�}e����iT1H�E�6���xI��jW� Z�	�)�i&i���M�nY�fy%�tD��WIǶHz��x����
��Y$�K�(�RL�Y�0+2nv����wLM1u�d�*b�%̂1���o?��>k��#��V�<ҹ>k������%L�f7����Yar��}8�l �M6�E%��1�Ճ�C�y��S�<E�S�<�H����"e۔"Rd�:+��xIx?F	��K#S�A�����"���^+R^gP��X������X���x��Aݾ��'ՙ�-G�;���u�B�.�4G�'���g��lU��+��$j͵������,w��`��iwG�%vF�<��YG�Ĭi��X��fY�p\1&w��T8 > Rh��ǌ/�9����M�RJ������%Ĵ.L%]g�s�b����q�B���g'��f�}���O}��0i;g�kT��֧A%c���{kv���-���T�?�ɑ+U�M������Q��a#Ff���΍L\t���d�u�ה��ش.�q9;g3�ik�m��y}�[E��J�Ynf�NQB�(*�h�6�C����H}�G���L�Uz��j0	L��(�>�6�/�c97���(��F7� ��*�?x��&1�
x���8��	L�^��"��(�ʱdy�ZJ�Hw���d��+�P!���ک�6�Ĳ�e�1R�&��#�����u4]X����.�����,��ki>��M8?f��*unu�w�6��U?��ѫ��������I/(tr��v�1{m��Y����K��\T���yR�#�9%ru,+�������������1?��Ѱ��{Վ!~M��c�R,��F˱S�}�Ng)�6p��1hV��[)p�`���?���=ڔ�i_8<�B7�up�wI!J��e�%殥@�7w�!��e�ʼ��ms���nO���:fu>m832��*-��_wӲ����j�h���g�g����ʷt�U�0���s�J�C��\mu�թd|���3'o���K�.r�>�� <|�W��H~�����f�ݖ&JW��j��H�|ւHMK��Z�L�t ʸ��&j��"�������cX���ҵ����tGW�%;}p?�<����;��d�#t�5vcT�qE�'M �*V��b�0-�'0mL�'���{�Y�c��R*v��A�XQP:�6kU��{�T��������^ )�I�V��9;�A�l1R�W\�I��u�m��g�q�$t��d����g3f^�o���,u8bע���L�B	� �@�o��1�����q6{a���Zĥ>n@��A��tX��50�(��@��8}�s�2k��VA ���CTL����J�f	=.���L�����G��q���^c�V�\�Y��R%�u2A�(�H-�|3�M��3��/���%�V���������j���Y���'�ns�6���(����.`/��5ݡ�/��c���� 48�S���x�c
1d���l��CA*g�L���6em�r�pt8|�2�G|�|��������8��NA�j��,H����&5���N�^Gﱉ 	���7�w�C��x��	T���id�L�z϶��1j<Q���dה K*Y�&efظ~azɮ��jiǶr�Zڒ�����@dxr��c'���f�Br��((�g 	aQ��0�b��*=C��.}��f�����5�9��Y,�&����ezVƠ��k�˖���m��W��"3g�7		l�1WH2�m��6¾�����l5�bWm��*�^A�fg��#{ݯ�k��:�_ʣ�����^��-Ї1&h����w�����4�!�)uq��I���\���-�����by����6�y�t�'O��-:�:��C�Ě_����k��؆s��A��ˠ�nU�����-���OԽII/�L^C/�Ot"��Щ��cC�ݛ�젊�W��x�[
���E����6���@S���W�]��������M_[$݋��^�t/{��%^�����LA�Tub˚><���`����ֻ-��?o��^���@	̀�G��uǈ�
%j�dh�f*ݤj+�C�#��=�v�����q�9��~�8̠(P�{9�Z��yI��2=�o�df�ޛ��-w�x[�݋��^�/�.��p�x��³�wHD����3C�0N2��3��K�6Q)�>?�z<�Oe�w�p-a��g<S�3Cu�>x��xꃏ_<���o��Խ��_³�x�򇯿z�e�������ܶ��-�4�z	O���'B���z�؈[�*�,��Г)��m'"�۩��������� ǓDY>̚Xª��Q�c�6I�h�:�l�)^�tg��Vw�xWwp���ĬC~Uy��4�h^�z�n�q\�B���3�f:�6q�3�m�0��[�I7i�!	1u糕f�(O�0+�f�M�t��v�ṋg@5�m	�-��V�����8��H�á�n^�ٓOs�[HL�N	��y��:&�<^�bgi��Ѵ������h
���E�V5:M1�6j�&(5��Ccn�Kܰ��|�1ꔂ��_-)�T�&ҹ����s����P�.����@�:��Fl�����Z�����uٓ}����쫡�T9�yrCqx����#N�B/B�ݑ;Z;��Љ8I�MQ:oلЪ��O\D��.�+�.T^�녥�A�����)��+B>�)�>�=Z*�dY�����߭LFO-
��Τ_9�E��ZO���%���e_"=��z�@��L=�0�['K�T�u	�"���C4�&)�փqWoBp�9ע������=����Ƒ=�+�>�␚�[�w�ʹIU�3#�0ԿC{b�U�?A۲�i�/���U۝��l�E)�{��w�2�����m��Q�W动1@u�s7;zz�NI�N��6��W��2���C����x�Y��@%�)M����3�����K8O�Z˭5��'i���6���&1h��-ɠ��R+��'=ӄ��T�K�����G]�=�ץ�3�2��-D��Q�񕳹-��ڥ6��V]��꣘������Jsnj�B��R�>/C)�2ſz(��f��0xL��!&SK.f��{���l�.���    ]��g�d�]V��+�Ćw�J�]6��T�]��Z��Z���*I��ʆ#"�?y��	��Nx	Ty)��8�:�sԄ�$.���'�K�̠
c��ʤ�K�����W�#:�ङT~
�;�N�;h!W?�*y�2{�vNv�R��O�x;׎_�ڜ&,�����=B���ŏr{��#D�	�٭��6j�IRv��M�PDG-�<�����Z`����T,���muS�`(v�R3qo%<�wN�*� �	��R���R�r��ݒ��T}?��������'O?�6�L_��}�Y��?���7/>{���w���!d�?�O���Pͦ[kG���Ш�$����t.�WU�vs
5�\�#���-[*0&cj1B[�ÔL�w-�ֶ����8���dx�EDo@�];�ccۓ*�2��E\�JG�U��n�]C�$�آ;A@�`���uOG�7ps��ܳb__�7(t��}�⽸�6g�y"L�r8��Ն�vvČ�F��'��G��n]����N��d�OlRfW�[<_�eK�^�Ӆ.E�+x��R�_����D�'vVu
u+B�@��LXv��mw0v��}���;%�.�=t���]�CI�%r��~J�~r_��ҁ�C��uj��,��S�My�KW7K9����t��.th/�t�I��'ǲP�U�Vv�u��&�c�t�l���!,a�ŵ� ��K���:8�B:�����Z����<bݪGH��1�1y6��xy?�p��J�K�b\j�S���U`��=<N��k&4�y���/k笡�t�zn�m��tmN�[�Ӕ�L�%׳�$�Fv�"8�[�$I��>r��At>%��������[J���.����,/���Gi�{��8fI���!�W�:����@'9���m$h�����W�2���N�bW\*o����E�#��zaX��0Ϗ�C��x�����~χ����-���VI��R
�b�0�h:�K+�2FO�����,�ڜY��;)1�R�����gl �p���|K�Aܽ,���]���a	�,�����W���t�;p}��+�z���ar-�d�j�9S���<�<�ٝ`�����#�$%C%g�b5 *�""5�-%'}5�V�]��6w������v�)^��[��d[�\��g@����I�G��.�<���+�"3<���o�<����X�����?��ų���b�����t��4�Uud�2�_�vD7����
�.�Ȉ�����s٭sE������+�0h:�b\��Tq�d6>�SW�����+t�Ǵ<���W���B�UɈ��񨈾��#tŗ1㜹�'qg;g��L���k�̀��Q�-���nͺ�s�J�B�|)P����3��F�A=��b,�.��^(��ٯ+�4����@�CKQ�	�:�(�V+`E;z6e{� 8B�~.�U>*A�'^�֛�SDp��x�Ӱ^�N��x_�G�]�C���U�A+4�g(S�s:z+��Ξn������ӣ����'��NX���*����W����Jh�:.4||�4��@� j�D-�?}�s�r����ܭ}�;�?���w�s����ʺ��a�p�$�p��ي�ա7��ąR��Q��h�9ZlÉ5z�r��a'��L	�x�ʉk���f6��g	ŝ����l{�7��y���e�;�	E+pJ9��u��[��P������2��Ӡ���v�{���T����ߴ0�z1��.�R��
q��Q>��hN���A��Q~�B��(_;s��ֿtV�s�d��V
ZW����i�6E�es�klQF��g��rLP����s�r��8�L3J)ْk��l��~��>`1!�m��G�"�n����v���r�'Wy�?|z���.�w����r��z��l�u����5}���Dw"}@!��{��Ak�e�E'����u�i`�������6]2[���uE ��H�f��O��K�d��-�i��������������!_�������'�>�!|����U�H����I��a��=�jM���g%3 �=���^�7��k�H���2sk��
�;�<*�a�Q�]������ۋ��Q� ]<b�}k�y�ӷfP�<��˯�@+6��<g�ċF�*��������͍G�b>�زyj/�qy;�����ck���ڱ�S�ڥ���+���[;�[wl�>Q�)/��`/qUp�%[Z'�QW1��t��"k����Ў���Vޫ��z����z����o���	o�#���pXo�]w�p1A@��YLp���l�;��;�Jr�����uE��6�.a�v�|.W�\�3σ�?"� T�Q��c�!6<~+�m�n��{��U�n��5�:�4��z9NZmʆ;������=;#�X�i���ϙ�6)��B+w��mw/3y{q�+��O]ﮰid����w�zH3��
�"f��/��`e�jr��Ы�m�
���D�;6�q�:���]���c�F�W����⻁���e''�{�C���Y+"\$� az�e^�i���9sꥋ�L좰���!&C.����5/��Ӟ��Yj�V�W���q4U�	_8��VvG�")w���������H��01Č=�Β�;�|�o8�w�2�D)�w�_�9�Y^�F�"�K2t�Q��T;����o��R���Ǉ�� �V|{K��E(I��1P��Nt?�/�}��t��t��t�;�fo��&E�US<�]�$�:�(l2I��f��%Z�}�26�C��g�l���씭��6��,㥶��d���aC 5Z��JW�!>lN鳍V2(I�=G��9��D"'�t 蚰�&l�	�_A�V�ť!;M��ī,�a���R�xI���}a� �X���A?���[	:�2+��NlA*yf���ɜ�8䃏_<���o��Խ��_³�x�򇯿z�e��������6�E8�-$\^H�:Y.vd�~U����1K��� w�Q��M���N�2o#�����y���{yc����1���T���P�V�AA�Nn�4h���<���S	��خ:�zX��AȏL���6#:w	J����� ���+Z�w#�ǥ�TI��6���ݰ1���+���Z��Ey��z6�+�G	�'BjϻKz�^�R���f��(�a�5I|p�/a���W�$��g136����*W�34�7\����+Z����2P���j��2�Lt��Ok��:���E�A�`����-�4�/>"�����.��zE�}����y���;A������c�vxM ׸k^���`�lfĢ�f7ۡ{E7���>�>@������������=�ѧ,)G'���.���\���+6�<���������/����]���+�������;��"���t��ߺ�t�=�{�A__�]^1������E=�����JO@5ɀsN��i���M9��s����u%g5��ޛ������:v�������5��j�BA�`�pc޶���H�)���6ܿ��m�Q7U�y+&�������QE�Mօ3��ȡNi#�g�W�҅��p��˛ڵW'q�Y
�mux�9ۧ�9��z;��$l�Ϗ~y�"�^�ķ�tG^�b'��6��G>����\])r�,J%AB�@>��6��B�L��p�vL!�L =3Dj�6�8��9��<��-8��bN�L쫑�4o��/�%�u�����;J�)"���#���D���$wy�p�_�Ԇӝ�����7�z�e̋�1����i<l�ir�V����fT�^S1��v#ے�Ĳ����F�dM�
��(��qR��c͆�R�T���T����=F���gGV"~�zHmw/H�^�eH	|�]��)���o�6����a��.�פҠ����.hoG�܉�6�_�J��Wr��~�7@�ȯ�=jZɻ�� �����{DY��/�M���`f��U����muxV�%���j��:��=���̵!������3��b���$��S�������c�g��V芲2��n �!���&4��y����*�   9���e������<���+m��m�I���i�)^�j��L�m���1��O.��ީz�W"~��w/&ՈFvPY���t$�z�8
;"W┐�]"�-��Ťn/����kM^o�(�I�)Uz�%��1��d.9ˆ���3޵2���'(eI�1o��C`��0<���n����Mx_���T�-O��)�Gn�:�l��ؒt��w�g�Eܽ u{qO@*rH~R��U�����\�3��9�
"u��<@�:\V�%�	�LN�種�:8��2�t��}��%��&P�Ȕ�m�3C�&�u}пR!���욋NS�I�8̠(�b���R;�:i�}��n���,���{sB7����"�^����� e���wkU<����Pd�k}d���"�����48svsS.ኩS���2��[��>*�R������ړGR��ƕ�e�%����N�u|��%;T	�R�%�7��[�R��Z��W�V��Vo��T��Tlt��
�m5�p�&�n���"�^=Z�����TG��}�V�h}���U�4����m`�w�q19�A�K^����O�����B�P�.,�͝H���Z]ѕ��t#��K���Z�a��Nl�|�q��V|�v�tP1�$�(l�A����}p���6�E�����#a��~���QZ���O{Ht��f��zQ�W2UJ�m��b���(^ap��6-�	�_2l�rLI��"*AǱ���J45��5���l�  ���p���G�` �e�$��gk����F��Ŷ9�s�����L�Rӻw����W�{qO J8��p��@nU��>?�(I�IZK6�y���@���Q��R�Y�hWTU����pδ��sXPu���A�ئ���U �H��+6�k
���s�6����I��N�ͧ�<r�m5�~��LP��4m������)�uTg9j{����Q���f�o���<�"|o�ۣ���#[Kb��	�R�}!����fsa����G����]90�[�t�ѭ*u���f��`J`���@����l����3�x�9#~�h�`!]j���CRg�����k����E/�Eg��j+�����﹇��t�Iw�����˞�b*M�%�j���'�<>��ʹp%�vu�K�W��ṆXkS9�߶T����o��u����P�ͫ�@�J�]��<�C�o*�a�R���v�65��5��>q���ao5��+/���vI�ĉO�äQB:�$��ha��i�G�������>�Ų�$Z[�q�ёY�t2�F��-���p� 8 ��,�S�u�8�)D�`�]k�$�Ap2̈����ʂ��P��P��P9�
�q9y�4K���+T\�:��FMi1�P;CLNnr����nQ9����N���r}�-*��&p(@4���2�]������M(���%\���f��`�&R	�޾|�W���Y*��m�
kc���m�<�F@��eo�H�W�����j�?�g���ɭ*�}���cNQ�/�l5�x�=�eH3��H3�.���}iO:�o���b��O�=�X�����D49J�DG-d?؇�YײS
�,q��H����Jz*J5A h׍#>{��C)U*���p���FC,�W��<KIa�1���tyg��҅�M܋�_��ĝ������[Jʁ�"吜�WQ�ÞM�.���IsQ#�ٍ�K�m2S[?�pm;�䶃��!�0ɫj�Gm;�p�;oA�8B�$�|�%��z!�9���}��-��"�w;m/�py��v�z\�����{�Nso��ԃv�X���`��mB9�F��]uJ�Q�8=�_kJ�!Zv,�?
V�>��v�-��F�n-G�6,O�����W=�y+4�ggv�a\��]��3 �cDX��֓�k,|�����"N��>�#n�(ã0if0T_��	E�:C���`$�ڍ��#x�tQ^J��[9[���������<?��~]��j~�~Z����63�Eҽ��*I7N+	�b���4=ߒ�� �F��I��̤H�Y�1pRb��87kC$6cc��&�绰�-��e&o/�	6I�xy��BX���OGm-L�� 6Qk���L
(N(6�$U�W��Gy��|��lw!1�9a(���/��0�9���Tl{�}������"l�������p˿��"t��^����~��ܧO�:��G���Y��%�C�a�ͺc-��=8=n7�C��d�2&��gJ1}��Ͽx��'�C��6�=�ߧ'��~�,nK1m�p��-$<����O�H1�s������YW�r�/�&���{k=�π���8�����r{$1˪n��z�-�ZcOM�ZSa��Ĺsb�o�F����Y^`d�1/_���*;y��RR�4�0��i�T������4��>�̚�pMV���w�`�@���J��u�vw�N����/�}��Ͽy�^��/���?�x���_=��|R^���wn��"�N��� Fu�Z3��
8���G�v�Ao�X0m���W(��B�nx�B�W�N�I;^y��Щ� ^:P̠6�� ��x�(��v:���1�s?�x	���b�ԑM�k�ߺ7�n>���/����L���������G|���>��n��	w��-$<����e�nݠ��<&j�t�F覷
�tsP�d�pa�1@��8�+p�]����xU��Q��]�Vj3,��]'(^Nل�i� n'Ҡ�:�
�a*�)/�W��r�:�V��\�IW�t�Rˆu�ߧH��'�z�ٿ���h�=�מ�ۿ꯭gf|����ׅX�z����?k�[=      �      x�ݝM�d�u���n(���8q�W�$ۄҰ�Zxc�'D�"��В`���9�3�&�z�j�N-�tE��̺�}?����~���߾z�����w�����/�ӿ�_�z�?�������������_�l���ڿ�_�����~���տ��e��?��o�O������|�������_��w׿���������o������ѽ�_������������/Z�L��r�Q��g�5t֫��s�%,�������ӏ���k�rn��6�U�2�*�_NΩ��r�}�RT�t�\8���͚h���nI�Q^a���-�w%���[l�LҨ�I��Z�iu��%�<5
��F�qZ(��ReF	�fM�m>E�K��������u�TN�b��S�d�h��ȗ�|���7�u��O~�����~�������_�/�?�����SH�
����7�<�,��~o~��������W�o�y���/?�?~�?�{�w��Ɨ��>����������?�����������������������?����i�+�Wާ\��~Ŕ��U��-�kbak�")�x�n�P�.i&u���=U2��Y4L zz��v&��G=-�*�D���5y�ji״WM#�PsϽ�-y�Ωa���09�U۵�S�B-[�$��[ļ�^;Ȓ�M���h�t���7��߼t�G��_W��r���)wb˾z���.Q��].p��oc;�h���a4�C{y�c@qd�M�L��8�b��$NJs�$�j��E�y�e�n+��O
c��� 	�v����B�1�G����_h��^��X΄!�k ���胟�	��T>N��ˡ��E�.?i�� o���[����n$����6�H�/�����^�ƹ�Ni���ނ���)V��z�*�n@f$�,5�f��Z8�����R����b��$M'�,iF35
��\�gU	8���Im��`�c�4�����q�6j!�D?+
�SJ>2w0���B���Ꝫ|�+O9��y7㻾���+��H��L�k�5b̗F�	U+�M�s[�C������)
�er��F��$*Tl%��b]�\A�9u��pw� )��ֵ�=C�U;�pV֌��?�)8Dؖ�@Z�":���f�����Y�By�U9eL]�=��[u���)������>���]Zї[s�����Z�P�W��_2��Ű�1�Ic��%���s�Ć�ڌ��@l�m�� �}��mmx���!�����lY7*Y#�;r�͊"��g�)%�Ă96��k
,I�����i �-��g��=g�x��\�[��\��ˬ����3�/�uY� �a��E������5�;֮��A_c$P�p�uI�5��/��Ł%����i�ܫ�\R��gH�:t�[��e��<V�-⧈�BF��̳q�c �8Ƞ-�!`�FQ,J��ň�O�Y�\(&��L��q~k�L���G'�X,܊��Bw�I��VNF��yC㳀��4��;� ڽ�G�\��+��nAI�镁������~VS|��၇É$V�$`.�T�=Eja�n[/�-�k�cMdĊ�_y&���9���A:3�N ^�(#���,�˛�����9kC�je����	�`�	9ǺH�\�h����k���@����w:zR����d�[?�#�GRQ�EE�";׶�ɻ��^������}��o��:������ϸ�LHa���fR.��zj��=��w!a�k�+���}=�K�8���j��q��^���#��-V���YK
x��e��)�x�1��c�R�����d���t��ca�ؕτ�'��0��ԖQ# �D��6h'R�0T��-��.姦�͸�nPq�/�><� �zM�|�s��\'�ɷ����6���K�Y���e#�4�?G�%�S��:3﨩�R��2�O��BM��c���(9o������$����w3Xj�
�0���"r�i��z�YwCw�]B�����4{@�S�"��'8��B������[x=��H�W�j j���ٮr
���z5�N�V�[�|R�CT&H�(o��
�F��+8}����[�H^ώ�v�Y\��&��V�`��^q���I�`x�Y��1N���v`W���`_�:HJ෭�m��RІ,�רia7ӏO�Ϟ��3�����)�ѥ!�r��c.�ɡ�:����_N����b���&�K�փ�Hu���"b@y������;u�M6t��늼ιz�����k�eX�I�fIp�6���/���b@�gB^��F��
_�0��¶�\�$a9���5��l] TJ ���jo}[ D	�{���}s�.-��ş�><��E�ȝ�6����G��?.,׸�o��֪���EN�cȟ�l9>G
�h�0��?�W�Z���K�"�Uɘ�ۄ�DB^���s���ݏ��I�|�ɠKn1`�ʌ$� 
��V�q��0�'B��I���[�G�"�=�b��F�_��r}ys6z���]��r��c���;O��ͫ j`�L�HE�v�7���Gm�Ѝ�)�[Y�R9]�܃5ݍMWl��R�Ċ�B�EN��Db�h���BҶ��Q�l (��Qʶ}cDaBlZ��k>�vN�nR�aH��J(��Y�9��if�5�"�4�%x�ԧhύ�|s�.5��y�OZs�x�/,��}��t��F�bz8уt��/M����4 P���O�glK�/m�Č.�m�;W�e�� �,�a�h������7�9՜5�E.A'�M8��&����h1G�3�j�ؖi�ȋj��d��H�}�B�����28K�He�jk�@r(��!̽�������A�}?��>Gv��׿��7���=E��En(W�3�>�.�R/i���y���W�W0=A6f��\�
gAq`6��V>wZ�<j��?��S��5�]�'M�6���O�5`Y��ֺ{L�/�ȝ�j�{��@�_��Y�H�<���IW"�68�W4^�w�ru�F^�'Ko���[
�ܐݟ�>>���6p���\�|J���Ir�?T��e��2�>U��E�\�8���vRY\	J�N�zu$h;�8���II��=qg+�C&;hNh��Q���<���.����`j�";k碥�p�55b/љ ��J+��0�C
༟����v��Y��􄨿x�M��_��í��N�;ֺ�+�±_�����I���<Dke貅�Vi���������c}�kq�	�!�51ME~!�4}�Sҽપ�0����|:����.��R�M�-���5�U��Y|�xupdy@�;�6N/������ �M�����>�v��~җ`���po�w���������]LV!�v�>�e�kt<�س1�BY��C���Z��+������UV(�N��=�醳2$��X|��|v*�U�I��t��P�-�&�̱	�	R�c����qN��w�'X�?e��`��o�|,�������.�!������V��
��+�6!����\eG���[0�1?�8��l�`�����3��[]V1l��}�~b�Z��R]�����3�K��4���u�`"�'�W�~p�邌�E^n}xL4��[?���+��.n�������Zނ�:���}M�e�y&�<N�[�Q�n,{��%�^I*d�6���{���8�L�O?N�Y��g4�i��b+2��_�6k9�4^�N�>�wb�k�u�X���;�3���wC��F�Ύ-�^������O�V^�Q�]j�p�ЧZsyV\��!J�\W�z�	O���B��~4�����%�{�?�z����@H껯�ݼ��8��)l��Q�]�����3"e�Ԡ�R����[c�3o��6�8._�p�|��u��N�p�#�}�.0�AVm�/�J��\�Q�����"N�>��FCD�9=7��g��o����*�%	�C�F$����H[}����l2`��,�t%r���~�f��͐Ί�']�r�h��ɫװd�)�Ȓ��uD�c>C�{�C��}������}[�.}t��ۭ�9�A������;Ox�q�'+�6��.<��b��|�	��5j1����~    Zۋ�������ؒ�#�ܪ˙_n�4���[p7����{������77����b�|�
�5s�{��;��xfi#���8ґK]
��b���� ��N���~���	�W�Q.`4W�|r��v��lX?l韬t8��"%Iw�x���{�gq����Ⱥw��������f�Β�cK �Z�|�
��7��z<9�>�hN�Ȼ�x��Ք[��p\��njH�p�/���F�z$�A�۬9w_�vz+?<]|H�}q	X�-O8'i���3B��Q̭ߡ���C�9/_�!1��M�/^?�6�%��x9>���{��~������u�ðw�QAʕ� ���M�s<��}��	�cu�ڄH���VId���S�'C�6���Bm$������3��AV���ξ�G��-�mٴ�C�r�
�/�!�m疵�hu��`�ˬ���ظ���1�@Юa�H�"���S������#��K���r���F��Z�I"��hԅ��jh��z� �/UMeN3_/�MU��ݐ|���a�})w mw�T�e�>�"ica��>7���9��U��N���;����
�H0!�,�s��sf_�������Kievr-�V���U�$=Z����7^�v�>��@�]r.� ݇��:�f�1*�:7��Ն���DK��)o]ېO2 �S�!4����!���kn�^)ZN�wT(.�㥞A4�b���m��������s�u.7��q�=��d_ yN\S_kK�l[�er�B��if�Xy<&�c`�}���AW�J�׬P�#�袾�����@�;z1qW����uY��Sܞ-��&Ё�T��T�鰓�VJA���["5��P�W�:�I� �L������!{l_TN��ǜ��qs��� ���>j�2W�ݣ=����}ズ;̽�!v�J=��W�9�>A�V��%�����Q�`u�Ҭ��[t���֙�p|�������=��f��D��F�M�7�emi����r��2�Z���Ē	��JN+����Aoq."+�%e�F��P�0�96A���`s<)�� ��*�wp1-�]�"�@<u$-�Hָ����\F�Yb����s˙|o�_�V�ߐ�U�"ӥ�#������Iz�w��噼���c�ݷ�Or����ͮVl^�k8�R���x�R:�-��>cxY��{Z(m���,�y���F^m��H�љ�)�+ݤ|H�$]�M=�����<����ݚ����c�h�_ kN�O+�o[��x��Sd��'KH)�?��$�C�/����kO�/�~���և����X�U�����.��^������[�Ǎ��DOM����.j�o�o��n�y/��*�ƀ�I��G��\���D���Ji]V�0�����|Y��Ru�(^��'p�Ss��xtl��U����L��J_ �S�'��/��:��@|Ξ���������|�,%�K{���q'�W@������ʼ:"y�-ܹCGo��l�'�
╖�V�y�6�}��r����Ҕ8��F`�`��.�����m^>i)h�
I��c��6۱{E����ت�	5�h ����G���q	Y������uk��>�	�g@�j�D�iY�K�=�2�E�!G��և�]̾e>��K�.�t�R�u���:���V��]6B��S���[S�d$�8�-�m�a�p��g61t)W4o��H:�ḾG|w_һ���+��e�ם{���;.������ݕl�.ä�D����V�� �)ĝ�Â� ����o[C�p�ϊ��.U��sE�>�ߡ�.B�W{���1�7�u^-��rnv���UշZ��ۛR��1��J���9	�c��-�u����^`�H(���c����b�Խ`f �t���[���p�gf��L|)9�[�{Xeng����vxx�T%�����*G�e �H���ǎN�����������G]jj������^f{�KptA%粴�yHm�z���-��z���������]�H`&�����݇g���h����٣�9����s�Y5�V������gb}�`h�Ǣ�x������3�*U�����_��U�yJ�z�ʩ�gKZ��g]�y>����<���1J[����1'y���0�W^A3[������1��*3�9� W�]b1��t���B?->Z���VH�D���������Nc�U�Hl��k�-����Fc/bg�/�%�:#x��Cs�똦����S�
�o<%��a/>����	�$;��i��=��|J�jshoW��IH&^C���s@Doў4<W���!V��W�ܗ[xH\�ƴkV^%G4x�F��{B�{��Y�HT����Y�8^��Â�x��W���Qw���gF��C�U�lo��,�Ma���2|�bW�#�3�ݠ׳$�py3��y��\�wtߊ���s�؂�_H��q����l-�x)&^[��hy?�!|4l�q��������e(���˵|ap8��/��p�{�B������}A{8��f���w�>���]�r����Y��T׹�J��t)��͈�{)S�}����\/m�^��r�j=�l߇�F�S`Ut�V&�����Y� �Ǌ��%/ED�������D����������$
O��ry�r��k�IiC�4��P�WF�6��X؅�a7�N;/�5����ͼ8������c^A���><R}R�pr[�,u��+�J5�s���|[��X)�������q]��=���/IL^�ӫ���I|'=*>�� ���)�;܁��;5��u^��{?/Q/>ȥ.7�89-���]��jW�Z[e$�Ž�0C='������(�;H�Ji�<)���x܌����N����0R�-�~0�#�}`'��x1_�'��	�^��!����6}j̲O\ m�ȅ�'៧�,q���ۥ�(���g�N�.�Zx���I��cN���}�N=0p����VM�%ؽs���.�n^�o�XJ��o�X��6�E}5z�>��gE�^�����ƺW�c�v��pz�&�|�7�\��� D�4�&�9�c�6M�lZZK�L[[	i���x�L�q�t?+$�zg�^4��1���|��1g��a�.�o����և�\�B�)����֎i�]z�o����4����,=4f������r��6o����ς����^k��\��������Zm��--iΛP�r���h�ג�̫#��|b�z��4���f��� ����[ʖ�N$�ݵ|���Զ��(�ϑ8�������w�R|D�h���և��ґ�Hz��v��jc��g+>��۴dL�G�k-� u達�|���0�WUen��
Q}�ㄉZ/�ʏI!��7x�d�0��}����#��e��b���L!T�j?�N�6��[i�U�em�U������X���_��$<�g��>�9��Sğ�><�z<^��xq�y�2Ϋ�k�j�*Q�s��w��.'���	]�}u���m�7��=2N��nۈYL�g״y���iH.��{��G}W�U��$MDKDݎu��j�3y�Y��MR�CGxQ�~1MeT4TU��e�}�F.���W�O���s�*L�$A����*:ݢ'��3y.c�o9<ɳ�}?=lR��yr�G���և��3�5F�:o2��.�XVțZ�[��$. {��-hiD0��/'D/ 3n���螕S�Oš��]O�����"���7���d�.����$Ԁ�[�o�'4'�b�j��	��	B����]x�F֘~��Zc9�N�xN�|�>�S�����<�'�>
��><�FOb�ۅ��؞k@ײW*a��6��WGE5Q���B4w�H{��O��k��Ƕ!�^d&��V�1�u��kzƞ�bOy^��� ���RJ�Y�������;���[���21o�3!Z��
���l<Q�D�Y���f��sW;�^z*���rܤ|�-�iY�gu��j��˔(����u慵�~pWG����-�R� �  7�+�G��2�����#�.���<�������*g9I�ᳳsٛ�!T��X���jN���1Bv�A|	_徸���S�0?膬��0O��h�������/���:_̋҅Qj��5v��;y��ߎ:����~����]Z��p52�%�c[i�t���I�|�<O�jB󎠱>s����ݼ ��v�
��\Dw�+lnټ�DHϗj��W�Sޒ3�-c�*L9�t'�"^rp����"����J����D���%�uN�S�y�q��2��,��~���T�s���;)�w���h��ǭ��ғ��q��%����K�/d�H�]߄�Jڪq�0�I1����2��߻��la��d/I��I�Ͳ����Dk?��K�|�� )�k��$�&Dl_�����������W$��Z*�>f9yN~��^߇�����n��/�u%?ɳ�?��{,�G�N>n}x��W��(y����V�^(cZЁ��ނ�r|O�y񇱽��:Uʁs
q���;no����XZY��LRM=��'d�:�(����-N%c��t��5wDX�PC�K$��/q[|s�9�LHr:����b���k�����:j�ҸK�l���V�W�)�����
]����>n}x�ἲϘ^n�|.�^��|�d�G/�7anO+���zՒ�OsF5��k���t����w:Ĩ��3H�D��:�� @�]������%�?�+�bi '�ic6����C�MS�H���������`��5�gm� ˏW��r�zI�'gb<?w��;̵gy�1�g�?/�6><���o:^H)�\`�\I0E~�E=_{�e�������:ߌ0}gjZH�M��v���{!T�_�xz?D��("��$�Pv�ӕ6����f?[��-_ ���3U�mh&~��[]�>u��������O�S�aH}�&�b9�����@'����O�s�8�4t����!Q,�Ϣ�E@��{�,���37��{���$5�%<��\��Oa��.���r��ob&חޫ]�䇻@c�J��U�Z2�
T�ϐb+��Q�1�j�x��s����$.dC�e8`��ނnDX�O?hȔ���9bSk��s�o�j|�2
���;��[~���Z|�I`�(x��,����p�t^r�"{=(i7�L!�W��;]nP	٬�u$6\�X���~�Q�+����k���>.3p6��d�;2i�t��X�#z�÷]<������1�ĺZ�F��U]�ի�k��h���&^�'9��%+�/�K�P��'��|ӅU���<�
.�[�D���c���Kު���%!K}"R�*�O��S,�ک�»��˭�����%E�H��^�'I� ?�Mv��^]NݏX�Jd�P2	��T�=�%�`�0�=��E<��/v�� ���^\����� b�B��s�_�x����J>ފ�����?��ī��8wn_;��ť��RG<;�qKL�r��m�3�R$���J?�kO�ْ��M�}X��~�j�/�><�$���f׹vj"I�~��aG��o����-��Vh=�Љ��s뜛Eb����e��2,>�F����'HX�!�m� �x,UR�O�d�h��v?�:���༓;�YV�	�~ȟ����8�gKI����j��;}�r�
D���F��?^|�g��K��_��/�><��X��@n�mYu^�e_h���z�o^��RD��t�����ir֝�,�e^��Z[jd~B��X�B���'p�W8��[�;b�C�/b���w��.])|D�͸O���
$�c�r&sz�c;�_�Ǽ�WhQŎ�t/z4�t���e��O< ����Sd��)����?��"�~�/�]��aWocM���߂;X$v2�`�r{��a"f������PB<�F��|�^`B��	' 0">���U�8�77v��I�o�H�����'�{-P �U[Hx�e�RNӴ@�.Q��^�ow�ߓ5_�p��lY�?47�z�KO��5�/�λ�޹�[w�MQ�qu�7|��"�Ç{3߄�&���pbC��5���5^���~�#��A��H�AL�>gB;~2���C�@?�9|y�8��#�Q:vW�VBv��� ��̑R�u�Q+�??2�xş��b�͝�4���c��|�%>}�V)����?|�>��q�?=�"�rz�����_�_}���      �      x�՜IWcIΆ��+8���s*|bP�o�
�<�bd*F��Oa:�MaH̦�n2����}B�+��������]�}c�������YlM����h��g鷥ޏ���響-�?��E<�gW�-]������%��]�躋�4�l4��{���<�ɏ=��]�����׻I?�q�/�[���,���{����+GTܣ`� 2�1��Kf9��)���ߖ�U�/X�`�g N�%13�J���`U����i������K������:`�@Fc�V�v�7��U�����V�`����E�����dY��0Wxc4O��:�g�m7��C���R3.�pK�}S��R-���U?���B��?Kl,u����.��X��cw����������K�t�+�f�a\bZ�$B�?�]^�_�p0�����Hn|*�Ph��Bd!JÔ/:� � ~���y4���m4=aQ��)9[�R�n���gK���ez����(�62�E3�3!�VR2:��Yx�k#ޅ���HxQ@��Z1<:���&�L����/8�/�Z��w�匵��0�5�D��e�e).q��'p�&=���������_���#۽�a9}�>
g�t�i�,��n�`�΢*��&׷�%��Ŕ�Ί��5�Ef��!�am$20%{+�Ő$��)�W�3ɓ��С|ٌ�])�ٽYX���}�0+Ý������ݷ���9���Y��-&�2f�h��o�c�[��tn>�k#���d %"$�mS��Ĕ
���"�E�����b�������Y�����6��_=ߝeo�6�S-R���8�9���$H���d	^΍�:|��X+���k��H^ *�e]H�q�,��,)��JXH���׌��T����}3y
�a>��Op�n\]�����������h���s���+�р�s�lKe���k��H^Q�5!$H��O^�D������*k�{�%V���I�[���I�(�?,�0�dQQ�����KVw��Zw k�{�����fS@����58
RG�p�H���*QM�><�8�1ߴ��mKpkՌy��Hx��Br�BQES:A�(�x�X��"��l7)[VY.�\n��Fr�.����2HnSa����ը0����������,�O�D��,�vn���������4�Wa �h�Ћ	bF���(�����	f�M`�ps���6�R|D���)�y'��)�Iz��f����m�|������\Yy�z�������/���������<D�(e�'G�C�YP��b�Acd����Ca���l��Hf�'/������S(A��N��@��W�۫�䅎E����Y�"�*c?��*Łi�T�P�-�IQ:�Z��2!���q%���s�H{P��p>�k#���V�0W��CgN͢�$��6E-o^c����ZZ��y�䵵��B"IH7&���]�ߊ@e��[^\X�����_���Suv�y��O���N��ޝm�����<��&6�S�AK��Ez�X���1O��s��|�����8O���6��m�@��R�L�1�R�r	I��l��/��ս�r��^;�X�����w�ؿܼ ���E�8Au_d�9K�<s�X�![�)�Z��)li.ɇ��6�W�/)�����B)&J�RZ�^ȿ�tD�.ڇzh.�Ս:���;��;v_����E#}0}}�R�М#��#��'��Q��
{���"����Yk#y�l�1%1��!�����(�� ^����f;"�ø���`�#�qs<Q�#���Gj�h�z�y�{� xs�P�a�/��e��XM��s��MKP���\^��F�
iiS���ֵR�a@ǔ3�	�����&�`Xv�} ��o��M��O�|��= g�"�����Q�d� ڤVmqQ�:�����մ�F�ϥVi�#�[����@ ����KB~�0-���W�l����d�\��R���i�j�M9Z�B�"��uD�n�E��~m>�k#�)\��D��n��O)���t����N�J���J
�W`�̮6Ʉ����҃��T�^��r��2$!�H��@��'+���a��ג���7��Hx�t���I��I9&D�X�y�	RJ_p�_���"�{�~X��Ma�b��QRܑ[�p͵�)F\���iC��t��&�np�;��ܚ��3�8������,P\�d�����3C+�P�n��,3��!�nl$1�A�T�T�%�� ����B��!�/�mB�L&�&l>�MV��x���w˭88��ի�ʉ��X��R�ԑt�Lc ���>l�BA0�}76������Xe��kQ��9hfhQ+	�Jm!6���Z_��aM^�ۻx�1[p~�������=ڍ��Bm瓠M*���@+Gk��&[�2@����@$�cBK>_@�Z�K��H��R�����[�KQSUk_�ל��/�q�jc"v���\���������~?��C+r ��� �`�g���Z��T���G�R�L%�|�8km$/+�⠀�Mڣnbg���<��\ȿ�T�;'�#q���b[?�v�h���@�����p��z1��xp����kSd���2S:��hb����gyi���ښ�*@�H�p_��Tb!ն�����C>����ʹ�u�H0�B!����+�Щ�:��k[�8WZ+tFHp2E%DW�닗!c!X�,�P?��u����d�)`|��ST��N�J8�Wto�����l�S)]{��	��I���ͫ��n�Sʢ� �r��6��	@��H�E֨9�+L{m���z�_u��{i<�"�@^\�����&��(zR�۩���Uw*�EQZ��X4�c�ft�#݈��������))q���Z	/�b�tw��	�!3�M�D������&HwXoT�k3������R%�YP°P$n�q����u{S����lc�t\�����R���=Y_�@��#8I�X@��O�X�����33�1�1�am$3���n�̚�Z�H�Es4NgTE�/2���oʲM��c�F�
��Ý���h؛<툧��x���L�VkJ�{�B����Eҕ)|2����@�C���Hb�Ȝ莓��ʈ���ta�V{PP���"��L��Zۿ;ۺ��F�N��.���::޿�^��(��GA���s�S� Y	X�ԙH~0>D���/�O���H^`U4VI�C��J
��Lʋ�1�/�z���a8F!�i��p�����8YQ�{{��2�馌��ϖSȻ����)��d��!��}���U������H^�C�ِ�0�ͫR'2�f�������9���ay8�{zܾ�;��w'�Vǣ�K����SD/�9�M����%g#� ?�|'bAط��7�F��҄��g��z~Wy��g"�	4�^�������p�0��~w�z�� ���1������bo�^���OAZ��$�
�]�Ҍ
3zk̠?oI@9_p�Iˢ礳�h�i�P;F�����(r�ɪ_ܑ4��d$���j�fS��&y�=���@%�>v�hC�0��wU�d(�@�����L	/�LKm�T����V�h��V;-�O�����7 :��T���Hx2b��L����c�DK���Q����{��o�f�|����Hn:z�Lm�[ 	�j#���;)_u�WUu7�N�nǗ$�0=�u/t;�V�2�'Q{2}�/z$x*�5uN�TR�Pi��$�1�΂�⡺��3��oo�����9��RPČ�0Fp�־�!{��|��~	n���;�r��Hn�dц�>��I���@�@�GE�.f��ӽ��������ږ	[v�޴Ώ3t��w����w�T�ٱ�
i"��?��N$�y��If�e8�o��k#�m�!�ȴ�Ģ�� �~fI�D3�J��f���m�t���k�7x���=�tVz�`�y�w�H���CK�(ִ��<e�rßѽPQ-�u�vw퍵��( �z����U�Pd���ADY���2��Yfs�!��o��On0���������Q��G�x��S�.Jp��l�u��^sڱuƹ(��c��#�[�}��f����#	W'h���R���p��s��T��� �  ~HQ��ӹ��>����V�ˣ����kqs�p}gZR�$/�g%�$O��ꎑŐ����O���RT@��꿱6�������e���Q��<'E����n^s�!�,���~��KeN������n��v>V��;/qNz�H^UL}ʋ�9�seJ(��?���N�(.�M����H^>8�L��j�22��YT���2Gyy�т�f�!��fe�>��=��x$F������s���I(H�[)L�z�vԂ�$�L�z�����I�Y"�x�����H^<�P�ӍW�^ȿ���G
��H�/�(�9��_�������0�����F���h�x�t�Пr%�W�:�O��>j&��	t(�_�M�:��H�����7�F��;�CI#I����2t��j���f���֚�Y׃��:;�jG�}����}�&[�Г��*#���)�Q��gc�M�d$y �����{ߴmIaP�տ�Zɫ�"<�>�9�.�DJQ�.��%�L�E-4=<��hh..'b����'�cW�����ӡLyE��I���)$C��*,��1��ǄH�$8ɿoR�,Z�x͵6��z�x���T ]V�i��R�䳟�'�=��}Ҩ:%B�&�z���XH���E��K��7��=0��C���J����G�z|%�-9�� a�U�K����b�zPPB��S�ճ�+ޱ6^)�g�c�>Rez���_�fU������!���!�N�q�am$7�k��Ѝ)@b��%&e/�־�~��^�hB-�$���)��o;�n'*#|R]�#��N�+�S���L��#I<r�H=��
���2�G�H�;'�Û�6�H�4<P��u
[fǜ�����Qu������܌.�{�~Xɍ$[�+B�;��xD���>�!&���B��y��޼�e{v9ho�\_��u�^����\t��t����Zk#�8Yt2
T[�m|M����쇵���&�4�c����,�Z�e'��$_��lv^�����V������t{"����;HW[C�o?�t�%Cٌ'^����'N�\H�*n }2�ɖP�Y7�ٌ���D1E'	��Ǒ��N�1���>�a6��X^><�?�ozGO7�x�s;�L���v�o:���rOH4TeSt����Z�>��;!��e^�\��y��6�W�;A>��
 ��۟>'f�c1��)��투��'G����<���x�|�f�@=]��=��_DL�)��3��G��D�WSM�����D�-��uf.�Yk#y�b���%�ά�g�}L����>[�P�6�C��A�����
��e��]_5O;[�����$�n�M�E:_��(�EK�o�T���`~x��iq������F�*�s� �*h���F}(�FM�u����x���;_����J��_�N���:��Ó��#ٛ�Bt�9cɡ<e-�<�Ӟ�QX�aH@��'�˴�U�i�Y�gx�����Cl      �   �  x��[]W[7}���%�Z�]:�ї��`�$qIHJ�����$��>G:��:@Kڎ���.W�������G򳝽��~�������E8>�����0��K<�}{���6.f��Yڠ����<]\����lF'����^ə*L�������|>;:�R��O{'���io��=���~~1���>��������9浗����?����p������h���g��N!KC��i��[g�;��i�I)��B�g��깘��%�hs02�zF&��^�0���g\ྔ�<�z�{������~W}�����雟���s�~|��j�P(�R;�57�r�y�o�P�;��g�G��4�ɢ˝W����'gy����j�_6h�7��_6��.7�b�f�?��e�A��)����ym�ON�ɢ���˝��٧�pz|u�`����j��v~�����o:l?��$_~vD�h�<�|�s��8 �rc���.�P�&x��/l�4G!�,���]��No���x�lk�7|��y���l��|���F��^3��c����e��A\fm�+JL��=�'�&�1�/���)��$�$�5(ϷFJx�AY�F�	]����hwK���<�濃�Z]���y~��{����o�~w�T��̈́E�D�1�n������+d_�>�T��]��j� i�IZ�j�	��31Y��U�j���,K�S{1s�$�dkyQ ��Wu%Lc�U�׎��v�����sI�M�ߜ�΁\�����o����
0�̭^����\YÅ���^��+�����t�W��Z�w�����F�X��z�r�d��^k��鯂�7����������t{�g�'����<�m��j�����d�@�H��K.�:�y{��J"�9i�n�w,뢯\�Ȅ����t���������e�,����QE�&�mR�W�d���q�\6�-�/���Zȟ��D� �\�~{9|kK���^��	�_W�� h�Q���6�F�UB�`���p���`�.ZxV�Q+ �҄����VF�m�T�~&O"�7�9.	�H2�C�[{�4I>�$3n4i�f��XA�I��|-�q5���Wrs0�1(������Iw�q��B�HM��\ �&Vsu��G��U�-<�@5v�GUw狓۠�o�.Pw=mK�/�B7�kMm���M��+�G�QZhug����PX�A�b.H��♍�8�(L��Do�@d*P)�@�LFFQ��Yfﮈ`y���b���'�q;r00����"���#�X���h�難�(W����q�)��+c��X'4��*�uH��M��f���΋nZ,ƻz�o�E�Z�Z
	\�0�i��"w=�}�|�R���i�'So��~Q�b!��$h�V��5�d\�p�-�+�P<r!�' H��8�d��1J�#1��\��aArNO���Z]-$�:������`̗C��LG�����SN:V�Ǐ#��/4�
r �+�o�WG��~v��+/�m�6%�YCj	�`����5k�?HN%��XR�����*F�-�H�Ye͕�	=U+�\]�Ƭk�������gA�HG�"�,��߂5dk�n?k��6o88I�X���ڝ���N�h���f�Ca_��U9f:Ju�	����x�G"C���0���:%�K:�2����QZ(�wR
�n�I��Ba�D*4�m�
�5U-f>��R�Cv�l���ք�eq�X�i��=a��JjK"����'�^�"�R�F�Z�=U��e��A�հ���Ҫ��\5�����b
0�l��dI͝��&9���ɜb"J���.RT0a��E�]`�PW]�dAE��l�}�6�,�j�A�;gwe[��G���Ð�5b�A�N��b��s��nC����B�h8v�wQ�)�չ�!�em�T�DC"C-�4�A0I�uN��h��%H�c$ɲ���E)�I�q�	i���n�t?"6�0���dX2��}����C;U��$w�F�Ii��_dz�&�{�P�1Y�-7F���g��o9�w��J#�Kn�@'���`�]4xv~	�G�w��ϮF�}���t�x:}GZ��D��@4��t}I4���3�8��#�*��Q0,ٲ`�d��I� �DtJ�����@`���w�%ctX�w*�������I��xw��dG�7vrt1�\n\�RH2�b�Viy�_X��R#�4�,7�� Z)�U�<��ӣ�m�l�o�~����ij9�l䊳KW�qA���Q�x�лr�"�1�*��O{�_��v�$��o\�]d�}IT��m�Ȥ�N55ĬPdkD),$N6D�u�)��Ҿ��'kV|�����ӝ��h��?
e[;1�F"X!�,Rp���*֌�9U�\���E�V:���شA]���\+�j�AH�M��k��r"OA�j
��@h���G�Kx�����~۽�;އ7��6�-麗1�JJ�WUٻ����C���׫z��ARxz����A=ӋJ/l���A)��������Y2���̃��}E��Y�^��\�����p?�}��&��O{��Ӎ(�U��[\�+��[�� �!�C�HA`��4=|;U�d�[$Ұf��2�\W.�B�r�4�EG�M�7H~M�(�)\틲E#�)���׆Tr�r! �Hn�%�#� R4�Y2 �ȖEM���J�Q$���\h�:�r�#\S�;	o Ɲ{�y��4^n˓W�⧓�+��*�e��g5��OlH��W?����57����m"�ņ�k����!T=h+ec��b�ek0�R|<tc;l���-o�Fc
�f8��tks�$��!��-t��Uc;n�5�A
Z�RH9�D�G�̬���h"*�*���� V��0̣�4d=��l���ݯmn�m�g�MG@�_�X�Њo[�Z���A6���C/��P����*7�|I>�������s2�vD�j�����d���X�u�`,$r�z��~Y�b~q\]Gx�,�o���CG�>�+V8
������tq������Og>V'ћ]��r$Xty
�����fK��z�z�qf�<�!�!xF���M`VR�Єΐ'Ĉl��k��x<�~W���<��U;?`���݋�7b��j�����kI$ޖH�L�~�mv�"�m8���K#�Ŧ��k'҉�R����V�e�R�n����&���<g	Z�+K�{�JtŃ��" X���ֿ��?���     