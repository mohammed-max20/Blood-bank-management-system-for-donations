from flask import Flask, render_template, request, session, redirect, url_for 
import mysql.connector
import secrets




app = Flask(__name__)
messages = []
app.secret_key = secrets.token_hex(16)





# اعدادات mysql
db_config = {
    'host': 'localhost',
    'user': 'root',
    'password': '',
    'database': 'bloodbankmanagementsystem'
}

# انشاء الاتصال بقاعدة البيانات
conn = mysql.connector.connect(**db_config)






@app.route('/')
def main_page():
    return render_template('main.html')

@app.route('/home')
def home():
    username = session.get('username')
    id_number = session.get('id_number') 
    cur = conn.cursor()
    cur.execute("SELECT blood_type FROM register WHERE id_number = %s", (id_number,)) 
    user_blood_type = cur.fetchone()

    if user_blood_type:
        # Check if the user is registered 
        cur.execute("SELECT * FROM register WHERE id_number = %s", (id_number,)) 
        is_donor = cur.fetchone()

        if is_donor:
            # Fetch critical cases with the same blood type
            cur.execute("SELECT * FROM patient WHERE blood_type = %s ", (user_blood_type[0],))
            critical_cases = cur.fetchall()

            if critical_cases:
                notification = "There are patients who need to donate blood. Help them by donating blood"
            else:
                notification = ""
        else:
            notification = ""
    else:
        notification = ""

    return render_template('home.html', notification=notification, username=username)


@app.route('/show_login_form')
def show_login_form():
    return render_template('login.html')

@app.route('/login', methods=['POST'])
def login():
    if request.method == 'POST':
        loginDetails = request.form
        username_or_id = loginDetails['username']
        password = loginDetails['password']
        
        cur = conn.cursor()
        cur.execute("SELECT * FROM register WHERE username = %s AND password = %s", (username_or_id, password))
        user = cur.fetchone()
        
        if not user:
            cur.execute("SELECT * FROM register WHERE id_number = %s AND password = %s", (username_or_id, password))
            user = cur.fetchone()

            
        
        if user:
            session['username'] = username_or_id
            session['id_number'] = user[0]  
            session['first_name'] = user[11]  
            session['middle_name'] = user[12]  
            session['last_name'] = user[13]                                       # Index
            session['phone'] = user[7]  
            session['email'] = user[3]  
            session['birth_date'] = user[8] 
            session['gender'] = user[9] 
            session['city'] = user[6]    
            session['blood_type'] = user[10]



            return redirect(url_for('home'))
        else:
            error_message = 'Login failed. Please verify your username or ID number and password.'
            return render_template('login.html', error_message=error_message)






@app.route('/show_register_form')
def show_register_form():
    return render_template('register.html')

@app.route('/register', methods=['POST'])
def register():
    if request.method == 'POST':
        userDetails = request.form
        id_number = userDetails['id_number']
        username = userDetails['username']
        f_name = userDetails['f_name']
        m_name = userDetails['m_name']
        l_name = userDetails['l_name']
        password = userDetails['password']
        confirm_password = userDetails['confirm_password']
        email = userDetails['email']
        nationality = userDetails['nationality']
        city = userDetails['city']
        phone_number = userDetails['phone_number']
        birth_date = userDetails['birth_date']
        gender = userDetails['gender']
        blood_type = userDetails['blood_type']
        security_question = userDetails['security_question']
        security_answer = userDetails['security_answer']
        
        cur = conn.cursor()
        cur.execute("INSERT INTO Register(ID_number, Username, F_name, M_name, L_name, Password, Confirm_password, Email, Nationality, City, Phone_number, Birth_date, Gender, Blood_type, security_question, security_answer) VALUES(%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)",
                    (id_number, username, f_name, m_name, l_name, password, confirm_password, email, nationality, city, phone_number, birth_date, gender, blood_type, security_question, security_answer))
      
        
        conn.commit()
        cur.close()
        return redirect(url_for('show_login_form'))





@app.route('/forgot_password')
def forgot_password():
    return render_template('forgot_password.html')

@app.route('/reset_password', methods=['POST'])
def reset_password():
    if request.method == 'POST':
        id_number = request.form['id_number']
        security_question = request.form['security_question']
        security_answer = request.form['security_answer']
        
        # Query the register table to check if the security question and answer match ويتأكد من رقم الهوية
        cur = conn.cursor()
        cur.execute("SELECT * FROM register WHERE ID_number = %s AND security_question = %s AND security_answer = %s", (id_number, security_question, security_answer))
        user = cur.fetchone()
        cur.close()
        
        if user:
            # If the security question and answer match, retrieve the password and display it
            password = user[2]  
            return render_template('password_display.html', password=password)
        else:
            # If the security question and answer do not match, display an error message
            error_message = 'Incorrect security question or answer. Please try again.'
            return render_template('forgot_password.html', error_message=error_message)



@app.route('/re_password')
def re_password_page():
    return render_template('re_password.html')


@app.route('/re_password', methods=['GET', 'POST'])
def re_password():
    if request.method == 'POST':
        # Retrieve the form data
        id_number = request.form['id_number']
        old_password = request.form['old_password']
        new_password = request.form['new_password']
        confirm_new_password = request.form['confirm_new_password']
        
        # Check if the old password matches the one stored in the database
        cur = conn.cursor()
        cur.execute("SELECT * FROM Register WHERE ID_number = %s AND Password = %s", (id_number, old_password))
        user = cur.fetchone()
        cur.close()
        
        if user:
            # Check if the new password matches the confirm password
            if new_password == confirm_new_password:
                # Update the password in the database
                cur = conn.cursor()
                cur.execute("UPDATE Register SET Password = %s WHERE ID_number = %s", (new_password, id_number))
                conn.commit()
                cur.close()
                # Redirect the user to a login page
                return redirect(url_for('show_login_form'))
            else:
                # If passwords don't match, show an error message
                error_message = "Passwords don't match"
                return render_template('re_password.html', error_message=error_message)
        else:
            # If ID number or old password is incorrect, show an error message
            error_message = "Incorrect ID number or old password"
            return render_template('re_password.html', error_message=error_message)
    else:
        # Render the password reset page
        return render_template('re_password.html')




@app.route('/password_display')
def password_display():
  return render_template('password_display.html')
    
    
@app.route('/policies')
def policies():
  return render_template('policies.html')

@app.route('/Financial_prize')
def Financial_prize_form():
    return render_template('Financial_prize.html')

@app.route('/Financial_prize', methods=['GET', 'POST'])
def Financial_prize():
    if request.method == 'POST':
        full_name = request.form['full_name']
        phone_number = request.form['phone_number']
        email = request.form['email']
        
        cur = conn.cursor()
        cur.execute("INSERT INTO financial_reward (full_name, phone_number, email) VALUES (%s, %s, %s)", (full_name, phone_number, email))
        conn.commit()
        cur.close()
        
        return redirect(url_for('Financial_prize', success=True))

@app.route('/blood_type')
def blood_type():
    return render_template('your_blood_type.html')

@app.route('/donor')
def donor():
    return render_template('donor.html')

@app.route('/donorform', methods=['POST', 'GET'])
def donor_form():
    if request.method == 'POST':
        id_number = request.form['id']
        # Check if there's a previously registered appointment
        if appointment_exists(id_number):
            warning_message = "You already have a scheduled appointment."
            return render_template('donor.html', warning_message=warning_message)

        f_name = request.form['firstName']
        m_name = request.form['middleName']
        l_name = request.form['lastName']
        neighborhood = request.form['neighborhood']
        city = request.form['city']
        street = request.form['street']
        hospital_name = request.form['hospital']
        phone_number = request.form['phone']
        gender = request.form['gender']
        email = request.form['email']
        blood_type = request.form['bloodType']
        birth_date = request.form['birthDate']
        appointment_datetime = request.form['appointmentDatetime']  

        # Assuming conn is your database connection object
        cur = conn.cursor()
        try:
            cur.execute("INSERT INTO Donor (ID_number, F_name, M_name, L_name, Neighborhood, city, street, Hospital_name, phone_number, Gender, Email, Blood_type, Birth_date, Appointment_datetime, status) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)", (id_number, f_name, m_name, l_name, neighborhood, city, street, hospital_name, phone_number, gender, email, blood_type, birth_date, appointment_datetime, True))
            conn.commit()
            cur.close()
            
            # يتم توجيه المستخدم على حسب المستشفى المختارة
            if hospital_name == "National Guard Hospital":
                return redirect(url_for('national_guard_hospital'))
            elif hospital_name == "King khalid University Hospital":
                return redirect(url_for('king_khaled_university_hospital'))
        except Exception as e:
            # Handle database errors
            conn.rollback()
            cur.close()
            return "An error occurred: " + str(e), 500

    return render_template('donor.html')

def appointment_exists(id_number):
    # Assuming you have a function to query the database and check if the donor has a scheduled appointment
    cur = conn.cursor()
    cur.execute("SELECT * FROM Donor WHERE ID_number = %s AND status = True", (id_number,))
    result = cur.fetchone()
    cur.close()
    return result is not None






@app.route('/patient')
def patient():
    return render_template('patient.html')

@app.route('/patientform', methods=['POST'])
def patient_form():
    if request.method == 'POST':
        id_number = request.form['id']
        if appointment_exists(id_number):
            warning_message = "You already have a scheduled appointment."
            return render_template('patient.html', warning_message=warning_message)
        f_name = request.form['firstName']
        m_name = request.form['middleName']
        l_name = request.form['lastName']
        neighborhood = request.form['neighborhood']
        city = request.form['city']
        street = request.form['street']
        hospital_name = request.form['hospital']
        phone_number = request.form['phone']
        gender = request.form['gender']
        email = request.form['email']
        blood_type = request.form['bloodType']
        birth_date = request.form['birthDate']
        notes = request.form['notes']
        appointment_datetime = request.form['appointmentDatetime']  # تخزين تاريخ الموعد

        
        cur = conn.cursor()
        cur.execute("INSERT INTO Patient (ID_number, F_name, M_name, L_name, Neighborhood, city, street, Hospital_name, phone_number, Gender, Email, Blood_type, Birth_date, Notes, Appointment_datetime) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)", (id_number, f_name, m_name, l_name, neighborhood, city, street, hospital_name, phone_number, gender, email, blood_type, birth_date, notes, appointment_datetime))
        conn.commit()
        cur.close()
        

  
        # إضافة بيانات المريض إلى قائمة الرسائل
        data = {
            'name': f_name + ' ' + m_name + ' ' + l_name,
            'phone': phone_number,
            'city': city,
            'bloodType': blood_type,
            'hospital': hospital_name
        }
        messages.append(data)
        


         # بعد تقديم المعلومات بنجاح، قم بتوجيه المستخدم إلى الصفحة المطلوبة
        if hospital_name == "National Guard Hospital":
            return redirect(url_for('national_guard_hospital'))
        elif hospital_name == "King khalid University Hospital":
            return redirect(url_for('king_khaled_university_hospital'))


    


# في العرض الرئيسي لمواعيد المتبرع
@app.route('/donation', methods=['GET', 'POST'])
def donation():
    if request.method == 'GET':
        # تحقق مما إذا كان المستخدم قد قام بتسجيل الدخول
        if 'username' in session:
            # إذا كان المستخدم قد قام بتسجيل الدخول، استرجع معلومات مواعيده فقط
            donor_id = session.get('id_number')
            cur = conn.cursor()
            cur.execute("SELECT * FROM Donor WHERE ID_number = %s", (donor_id,))
            donor_data = cur.fetchone()  # استرجع بيانات المتبرع
            cur.close()
            
            if donor_data:
                return render_template('donation.html', donor=donor_data)
            else:
                return render_template('donation.html', error="You don't have an appointment.")

    # تحتاج إلى إضافة تعليمة return هنا في حالة انتهاء الدالة دون إرجاع أي شيء
    return render_template('donation.html')  # أو أي تحديثات أخرى تتعلق بالطلب




@app.route('/Questions_after_login')
def Questions_after_login():
    return render_template('Questions_after_login.html')




@app.route('/blood_car_donor')
def blood_car_donor():
    return render_template('blood_car_donor.html')


@app.route('/submit_blood_car_request', methods=['POST'])
def submit_blood_car_request():
    
  
        blood_car_data = request.form
        full_name = blood_car_data['full_name']
        id_number = blood_car_data['id']
        if request.method == 'POST':
         if appointment_exists(id_number):
            warning_message = "You already have a scheduled appointment."
            return render_template('blood_car_donor.html', warning_message=warning_message)
        contact_number = blood_car_data['contact_number']
        age = blood_car_data['age']
        gender = blood_car_data['gender']
        blood_type = blood_car_data['bloodType']
        weight = blood_car_data['weight']
        request_date = blood_car_data['request_date']
        request_time = blood_car_data['request_time']
        city_name = blood_car_data['city']
        neighborhood_name = blood_car_data['neighborhood_name']
        location = blood_car_data['location']
        street_name = blood_car_data['street_name']
        address_description = blood_car_data['address_description']
        health_conditions = blood_car_data['health_conditions']

        cursor = conn.cursor()
        sql_query = "INSERT INTO blood_car_req (full_name, ID_number, contact_number, age, gender, blood_type, weight, request_date, request_time, city_name, neighborhood_name, location, street_name, address_description, health_conditions) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)"
        values = (full_name, id_number, contact_number, age, gender, blood_type, weight, request_date, request_time, city_name, neighborhood_name, location, street_name, address_description, health_conditions)
        
        cursor.execute(sql_query, values)
        conn.commit()
        cursor.close()

        return redirect(url_for('Questions_before_donating'))
    

@app.route('/index2')
def index2():
    return render_template('blood_car_donor.html')





@app.route('/Questions_before_donating')
def Questions_before_donating():
    return render_template('Questions_before_donating.html')

@app.route('/submit_questionnaire', methods=['POST'])
def submit_questionnaire():
    if request.method == 'POST':
        # استخراج البيانات الى الاستبيان
        name = request.form['name']
        id_number = request.form['id_number']
        blood_type = request.form['blood_type']
        gender = request.form['gender']
        # استخراج الإجابات على الأسئلة
        q1 = request.form['q1']
        q2 = request.form['q2']
        q3 = request.form['q3']
        q4 = request.form['q4']
        q5 = request.form['q5']
        q6 = request.form['q6']
        q7 = request.form['q7']
        q8 = request.form['q8']
        q9 = request.form['q9']
        q10 = request.form['q10']
        q11 = request.form['q11']
        q12 = request.form['q12']
        q13 = request.form['q13']
        q14 = request.form['q14']
        q15 = request.form['q15']
        q16 = request.form['q16']
        q17 = request.form['q17']
        q18 = request.form['q18']
        q19 = request.form['q19']
        q20 = request.form['q20']
        q21 = request.form['q21']
        q22 = request.form['q22']
        q23 = request.form['q23']
        q24 = request.form['q24']
        q25 = request.form['q25']
        q26 = request.form['q26']
        q27 = request.form['q27']
        q28 = request.form['q28']
        q29 = request.form['q29']
        q30 = request.form['q30']
        q31 = request.form['q31']
        q32 = request.form['q32']
        q33 = request.form['q33']
        q34 = request.form['q34']
        q35 = request.form['q35']
        q36 = request.form['q36']
        q37 = request.form['q37']
        q38 = request.form['q38']
        q39 = request.form['q39']
        q40 = request.form['q40']
        q41 = request.form['q41']
        q42 = request.form['q42']
        q43 = request.form['q43']
        q44 = request.form['q44']
        q45 = request.form['q45']
        q46 = request.form['q46']
        q47 = request.form['q47']
        q48 = request.form['q48']
        q49 = request.form['q49']
        q50 = request.form['q50']
        q51 = request.form['q51']
        q52 = request.form['q52']
        q53 = request.form['q53']
        

        
        # قم بإدراج البيانات في قاعدة البيانات
        cur = conn.cursor()
        cur.execute("INSERT INTO blood_donation_questionnaire (name, id_number, blood_type, gender, q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, q12, q13, q14, q15, q16, q17, q18, q19, q20, q21, q22, q23, q24, q25, q26, q27, q28, q29, q30, q31, q32, q33, q34, q35, q36, q37, q38, q39, q40, q41, q42, q43, q44, q45, q46, q47, q48, q49, q50, q51, q52, q53) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)", (name, id_number, blood_type, gender, q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, q12, q13, q14, q15, q16, q17, q18, q19, q20, q21, q22, q23, q24, q25, q26, q27, q28, q29, q30, q31, q32, q33, q34, q35, q36, q37, q38, q39, q40, q41, q42, q43, q44, q45, q46, q47, q48, q49, q50, q51, q52, q53))
        conn.commit()
        cur.close()
       
        # قم بتحويل المستخدم إلى صفحة أخرى بعد تقديم الاستبيان
        return redirect(url_for('thank_you'))


@app.route('/thank_you')
def thank_you():
    return render_template('thank_you.html')



@app.route('/national_guard_hospital')
def national_guard_hospital():
    return render_template('National_Guard_Hospital.html')



@app.route('/king_khaled_university_hospital')
def king_khaled_university_hospital():
    return render_template('King_Khaled_University_Hospital.html')



@app.route('/edit_profile_page')
def edit_profile_page():
    # Retrieve user data from the database based on the logged-in user
    username = session.get('username')
    if username:
        cur = conn.cursor()
        cur.execute("SELECT * FROM register WHERE username = %s", (username,))
        user_data = cur.fetchone()
        cur.close()
        if user_data:
            return render_template('edit_profile.html', user=user_data)
    


@app.route('/edit_profile', methods=['POST'])
def edit_profile():
    if request.method == 'POST':
        # Retrieve form data
        id_number = request.form['id_number']
        f_name = request.form['f_name']
        l_name = request.form['l_name']
        phone_number = request.form['phone_number']
        email = request.form['email']
        city = request.form['city'] 
        # Update user profile in the database
        cur = conn.cursor()
        update_query = "UPDATE Register SET F_name = %s, L_name = %s, Phone_number = %s, Email = %s, City = %s WHERE ID_number = %s"
        cur.execute(update_query, (f_name, l_name, phone_number, email, city, id_number))
        conn.commit()
        cur.close()
        
        # Redirect the user to the home page after updating the profile
        return redirect(url_for('home'))



@app.route('/delete_account', methods=['POST'])
def delete_account():
    if request.method == 'POST':
        # Retrieve user ID from the form
        id_number = request.form['id_number']
        
        # Delete user account from the database
        cur = conn.cursor()
        delete_query = "DELETE FROM Register WHERE ID_number = %s"
        cur.execute(delete_query, (id_number,))

   # Delete user data from other related tables
        delete_related_data_query = "DELETE FROM patient WHERE ID_number = %s"
        cur.execute(delete_related_data_query, (id_number,))

         # same thing
        delete_related_data_query = "DELETE FROM donor WHERE ID_number = %s"
        cur.execute(delete_related_data_query, (id_number,))

        # same thing
        delete_related_data_query = "DELETE FROM blood_car_req WHERE ID_number = %s"
        cur.execute(delete_related_data_query, (id_number,))

        conn.commit()
        cur.close()
        
        # Clear session and redirect to the main page
        session.clear()
        return redirect(url_for('main_page'))



@app.route('/messages')
def messages_page():
    cur = conn.cursor()
    cur.execute("SELECT * FROM patient")
    patients_data = cur.fetchall()
    cur.close()
    return render_template('messages.html', patients=patients_data)




@app.route('/blood_donor_experience')
def blood_donor_experience():
    cur = conn.cursor()
    cur.execute("SELECT experience, donor_name FROM blooddonorexperience")
    experiences_data = cur.fetchall()
    cur.close()
    return render_template('blood_donor_experience.html', experiences=experiences_data)

@app.route('/submit_experience', methods=['POST'])
def submit_experience():
    if request.method == 'POST':
        experience = request.form['experience']
        donor_name = request.form.get('donor_name', 'Anonymous')
        cur = conn.cursor()
        cur.execute("INSERT INTO blooddonorexperience (donor_name, experience) VALUES (%s, %s)", (donor_name, experience))
        conn.commit()
        cur.close()
        
        return redirect(url_for('blood_donor_experience'))




@app.route('/cancel_donation', methods=['POST'])
def cancel_donation():
    if request.method == 'POST':
        ID_number = request.form.get('ID_number')  
        # Delete the record from the donor table
        cur = conn.cursor()
        cur.execute("DELETE FROM Donor WHERE ID_number = %s", (ID_number,))
        conn.commit()
        cur.close()
        return redirect(url_for('donation'))
 

@app.route('/modify_donation', methods=['POST'])
def modify_donation():
    if request.method == 'POST':
        # Extract form data for modification ( new appointment date/time)
        new_appointment_datetime = request.form['new_appointment_datetime']
        ID_number = request.form.get('ID_number') 
        # Update the appointment date/time in the database
        cur = conn.cursor()
        cur.execute("UPDATE Donor SET Appointment_datetime = %s WHERE ID_number = %s", (new_appointment_datetime, ID_number))
        conn.commit()
        cur.close()
        return redirect(url_for('donation')) 




if __name__ == '__main__':
    app.run(debug=True)


