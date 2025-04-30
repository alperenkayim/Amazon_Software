-- ✅ GÜNCELLENMİŞ VERİTABANI ŞEMASI: rank_history tablosu güncellendi
-- Artık category yerine gerçek kategori adı (category_path) tutulur

CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    asin VARCHAR(20) UNIQUE NOT NULL,
    title TEXT,
    brand TEXT,
    category TEXT,
    sub_category TEXT,
    variation_count INTEGER,
    seller_count INTEGER,
    fulfillment_type TEXT,
    seller_country TEXT,
    image_url TEXT,
    creation_date DATE,
    data_source TEXT,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE keyword_analytics (
    id SERIAL PRIMARY KEY,
    keyword TEXT,
    search_volume INTEGER,
    total_revenue NUMERIC,
    average_revenue NUMERIC,
    average_price NUMERIC,
    average_bsr INTEGER,
    average_reviews INTEGER,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE keyword_product_stats (
    id SERIAL PRIMARY KEY,
    keyword_analytics_id INTEGER REFERENCES keyword_analytics(id),
    product_id INTEGER REFERENCES products(id),
    parent_sales INTEGER,
    asin_sales INTEGER,
    parent_revenue NUMERIC,
    asin_revenue NUMERIC,
    fees NUMERIC,
    active_seller_count INTEGER,
    ratings NUMERIC,
    review_count INTEGER,
    size_tier TEXT,
    buybox_owner TEXT,
    dimensions TEXT,
    weight TEXT,
    data_source TEXT,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE product_details (
    id SERIAL PRIMARY KEY,
    product_id INTEGER REFERENCES products(id),
    monthly_revenue NUMERIC,
    monthly_sales INTEGER,
    listing_health_score NUMERIC,
    fulfillment_method TEXT,
    revenue_calculation_note TEXT,
    current_stock_levels JSONB,
    main_rank INTEGER,
    sub_rank INTEGER,
    estimated_sales INTEGER,
    data_source TEXT,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE rank_history (
    id SERIAL PRIMARY KEY,
    product_id INTEGER REFERENCES products(id),
    category_path TEXT,  -- Örnek: 'Sports & Outdoors'
    rank INTEGER,
    record_time TIMESTAMP DEFAULT NOW()
);

CREATE TABLE review_count_history (
    id SERIAL PRIMARY KEY,
    product_id INTEGER REFERENCES products(id),
    review_count INTEGER,
    record_time TIMESTAMP DEFAULT NOW()
);

CREATE TABLE price_history (
    id SERIAL PRIMARY KEY,
    product_id INTEGER REFERENCES products(id),
    price NUMERIC,
    record_time TIMESTAMP DEFAULT NOW()
);

CREATE TABLE error_logs (
    id SERIAL PRIMARY KEY,
    product_id INTEGER REFERENCES products(id),
    stage TEXT,
    error_message TEXT,
    traceback TEXT,
    timestamp TIMESTAMP DEFAULT NOW()
);