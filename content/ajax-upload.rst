Ajax upload.
############

:date: 2015-02-11 
:tags: python, tutorial, tests
:slug: ajax-upload
:category: Разное
:authors: zdimon77@gmail.con


Requirements.

    -e git+https://github.com/zmathew/django-ajax-upload-widget.git#egg=ajax_upload


Copy js libs ajax_upload from packeges to our static folder in any app.

Add to INSTALL_APPS.

.. code-block:: python

        
    INSTALLED_APPS = (
        [...]
        'ajax_upload',
    )


Model.


.. code-block:: python

    class Images(models.Model):
        image = models.ImageField(blank=True, verbose_name=_(u'Image'), upload_to='course_images')


Form.

.. code-block:: python


    from ajax_upload.widgets import AjaxClearableFileInput
    from django import forms
    from course.models import Images

    class ImageForm(forms.ModelForm):
        class Meta:
            model = Images
            fields = ( 'image', )
            widgets = {
                'image': AjaxClearableFileInput
            }


View.

.. code-block:: python

    def my_view(request,lesson_id):
        lesson = Lesson.objects.get(pk=lesson_id)
        if request.method == 'POST':
            form = ImageForm(data=request.POST, files=request.FILES)
            if form.is_valid():
                form.save()
                return redirect(reverse('lesson_edit', args=[lesson.id]))
        else:
            form = ImageForm()

        context = {'lesson': lesson, 'form': form}
        return render_to_response('lesson_edit.html', context, RequestContext(request))


.. code-block:: html

        <script src="{% static 'ajax_upload/js/jquery.iframe-transport.js' %}"></script>
        <script src="{% static 'ajax_upload/js/ajax-upload-widget.js' %}"></script>


       [...]


        <form action="" method="POST" enctype="multipart/form-data">
            <h1>ssss</h1>
            {% csrf_token %}
            {{ form.as_p }}
            <input type="submit" value="Save"/>
        </form>
        <script>
            $(function() {
                AjaxUploadWidget.autoDiscover();
            });
        </script>

