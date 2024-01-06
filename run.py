from app import app
from Routes.routes_home import home_bp
from Routes.routes_page_not_found import page_not_found_bp

# Register Blueprints
app.register_blueprint(home_bp)
app.register_blueprint(page_not_found_bp)

if __name__ == '__main__':
    app.run(debug=True, port=5600)
