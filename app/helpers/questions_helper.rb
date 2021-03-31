# frozen_string_literal: true

module QuestionsHelper # rubocop:todo Style/Documentation
  def link_to_add_input_answer(name, f, association, **_args) # rubocop:todo Naming/MethodParameterName
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render('questions/input_answer', f: builder)
    end
    link_to(name, '#', class: 'add_fields', data: { id: id, fields: fields.gsub("\n", '') })
  end

  def link_to_add_radio_answer(name, f, association, **_args) # rubocop:todo Naming/MethodParameterName
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render('questions/radio_answer', f: builder)
    end
    link_to(name, '#', class: 'add_fields', data: { id: id, fields: fields.gsub("\n", '') })
  end

  def link_to_add_check_answer(name, f, association, **_args) # rubocop:todo Naming/MethodParameterName
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render('questions/check_answer', f: builder)
    end
    link_to(name, '#', class: 'add_fields', data: { id: id, fields: fields.gsub("\n", '') })
  end
end
