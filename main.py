from flask import Flask, render_template, request, session, redirect
from flask_sqlalchemy import SQLAlchemy
from datetime import datetime
from werkzeug.utils import secure_filename
import json  # to use config file
import os  # to upload files in directory config file
import math  # to use ceiling function in pagination

# loading the config file
with open("config.json", "r") as config_file:
    params = json.load(config_file)['Parameters']

app = Flask(__name__)
# setting the secret key required to upload a file
app.secret_key = 'super-secret-key'
app.config['UPLOAD_LOCATION'] = params['file_upload_location']

# IF true then we are using the local server instead of production server
if params['local_server']:
    app.config['SQLALCHEMY_DATABASE_URI'] = params['local_URI']
else:
    app.config['SQLALCHEMY_DATABASE_URI'] = params['local_URI']

db = SQLAlchemy(app)


# Database table to keep track of contact me messages
class Contacts(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(80))
    email = db.Column(db.String(120))
    phone = db.Column(db.String(120))
    msg = db.Column(db.String(120), unique=True)
    date = db.Column(db.String(120))


# Database table to keep track of posts
class Posts(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(80))
    author = db.Column(db.String(80))
    slug = db.Column(db.String(120))
    content = db.Column(db.String(1200))
    image_file = db.Column(db.String(120))
    date = db.Column(db.String(120))


# endpoint for the file to be uploaded
@app.route("/uploaded", methods=['GET', 'POST'])
def file_upload():
    # If user is already logged in
    if 'user' in session and session['user'] == params['admin-user']:
        if request.method == 'POST':
            f = request.files['file_uploading']
            f.save(os.path.join(app.config['UPLOAD_LOCATION'], secure_filename(f.filename)))
    # After successfully uploading file, redirecting to admin dashboard
    return redirect('/dashboard')


# Admin dashboard endpoint
@app.route("/dashboard", methods=['GET', 'POST'])
def dashboard():
    # If user is already logged in
    if 'user' in session and session['user'] == params['admin-user']:
        posts = Posts.query.all()
        return render_template('dashboard.html', params=params, posts=posts)
    # Asking user to login
    if request.method == 'POST':
        uname = request.form.get('uname')
        user_password = request.form.get('password')
        # Checking if the user's credentials are correct
        if uname == params['admin-user'] and user_password == params['admin-pass']:
            session['user'] = uname
            # fetching all the posts form database
            posts = Posts.query.all()
            return render_template('dashboard.html', params=params, posts=posts)
    # IF credentials are wrong, then re-attempt
    return render_template('login.html', params=params, year=datetime.now().year)


# endpoint for logging out and redirecting to dashboard endpoint to log in again
@app.route("/logout")
def logout():
    session.pop('user')
    return redirect('/dashboard')


# endpoint to edit posts or to update posts
@app.route("/edit/<string:id>", methods=['GET', 'POST'])
def edit(id):
    # If user is already logged in and then user can edit the post
    if 'user' in session and session['user'] == params['admin-user']:
        if request.method == 'POST':
            title = request.form.get('Title')
            author = request.form.get('Author')
            slug = request.form.get('Slug')
            image_file = request.form.get('Img_file')
            content = request.form.get('Content')
            # To add a new post
            if id == '0':
                post = Posts(title=title, author=author, slug=slug, image_file=image_file, content=content,
                             date=datetime.now())
                db.session.add(post)
                db.session.commit()
                return redirect('/dashboard')
            # To update posts
            else:
                posts = Posts.query.filter_by(id=id).first()
                posts.title = title
                posts.author = author
                posts.slug = slug
                posts.img_file = image_file
                posts.content = content
                posts.date = datetime.now()
                db.session.commit()
                # redirecting to admin dashboard after updating post
                return redirect('/dashboard')

        post = Posts.query.filter_by(id=id).first()
        return render_template('edit.html', params=params, post=post, id=id)


# endpoint to delete a post
@app.route('/delete/<int:post_id>', methods=['GET', 'POST'])
def delete(post_id):
    # if user is logged in then user can delete the posts
    if 'user' in session and session['user'] == params['admin-user']:
        try:
            post = Posts.query.get_or_404(post_id)
            db.session.delete(post)
            db.session.commit()
            return redirect('/dashboard')
        except ValueError:
            return "Error deleting this post..."
    return "Post not deleted"


# endpoint for blog's home page
@app.route("/")
def home():
    # fetching all posts
    total_posts = Posts.query.all()
    # finding total number of pages to get the last one
    last = math.ceil(len(total_posts) / int(params['no_of_posts']))
    page_num = request.args.get('page')
    if not str(page_num).isnumeric():
        page_num = 1
    page_num = int(page_num)
    # no of posts to be displayed per page
    posts_to_be_displayed = total_posts[(page_num - 1) * int(params['no_of_posts']):(
            (page_num - 1) * int(params['no_of_posts']) + int(params['no_of_posts']))]
    # if user is on first page
    if page_num == 1:
        prev_page = '#'
        next_page = '/?page=' + str(page_num + 1)
    # if user is on last page
    elif page_num == last:
        prev_page = '/?page=' + str(page_num - 1)
        next_page = '#'
    # middle pages
    else:
        prev_page = '/?page=' + str(page_num - 1)
        next_page = '/?page=' + str(page_num + 1)
    return render_template('index.html', params=params, year=datetime.now().year, prev_page=prev_page,
                           next_page=next_page, posts=posts_to_be_displayed)


# endpoint to display each post by post's slug
@app.route("/posts/<string:post_slug>", methods=['GET'])
def post_func(post_slug):
    # first post with the same slug as required
    post = Posts.query.filter_by(slug=post_slug).first()
    return render_template('post.html', params=params, year=datetime.now().year, post=post)


# endpoint to display about page
@app.route("/about")
def about():
    return render_template('about.html', params=params, year=datetime.now().year)


# endpoint to display contact page
@app.route("/contact", methods=['GET', 'POST'])
def contact():
    # If user submits a contact form then adding that entry in database
    if request.method == 'POST':
        name = request.form.get('Name')
        email = request.form.get('Email')
        phone = request.form.get('Phone_no')
        msg = request.form.get('Msg')
        entry = Contacts(name=name, email=email, phone=phone, msg=msg, date=datetime.now())
        db.session.add(entry)
        db.session.commit()
        # Sending email code to be used if required (not used yet)
    return render_template('contact.html', params=params, year=datetime.now().year)


# Debug is set true to have realtime changes like live server
app.run(debug=True)
