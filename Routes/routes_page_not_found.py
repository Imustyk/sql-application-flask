from flask import Blueprint, redirect, url_for



page_not_found_bp = Blueprint('page_not_found_bp', __name__)


@page_not_found_bp.app_errorhandler(404)
def page_not_found(error):
    return redirect(url_for('home_bp.dashboard'))