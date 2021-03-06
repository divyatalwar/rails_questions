module ApplicationHelper

  def add_nested_fields(number, object_form, form_object_builder, nested_form_builder)
    number.times {object_form.choices.build}
    i = -1
   form_object_builder.fields_for nested_form_builder.to_sym do |builder|
      i = i + 1
      render :partial => "admin/questions/choice" , :locals => {:@counter => i + 1, :@no_of_questions => number, :f => builder }
    end
  end

  def get_number_of_questions
    (1..5).to_a
  end


  def add_boolean_nested_fields(number, object_form, form_object_builder, nested_form_builder)
    number.times {object_form.choices.build}
    i = -1
    form_object_builder.fields_for nested_form_builder.to_sym do |builder|
      i = i + 1
      render :partial => "admin/questions/boolean_choice" , :locals => { :@counter => i + 1, :f => builder }
    end
  end

  
  def check_user_type(hash, choice)
    if hash["controller"].start_with?('admin')
      if choice.present?
        return choice.correct
      else
        return true
      end
    else
      return false
    end
  end

  def is_active?(page_name)
    if page_name == 'root'
      "active" if params[:controller] == 'quizzes'
    else
      "active" if params[:controller] == 'admin/' + page_name
    end
  end


end
