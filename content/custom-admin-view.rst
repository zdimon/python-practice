Custom admin view.
##################

:date: 2015-02-11 
:tags: python, tutorial, tests
:slug: custom-admin-view
:category: Разное
:authors: zdimon77@gmail.con


Some admin class.


.. code-block:: python

    list_display = (... 'export_to_mirror_link')

    def export_to_mirror(request,issue_id):
        messages.success(request, 'Export is runing!')
        return redirect(reverse('admin:journal_issue_changelist'))


    def export_to_mirror_link(self, instance):
        if instance.id is None:
            return ''
        url = reverse('admin:export_to_mirror', args=[instance.id])
        return u'<a href="{0}">{1}</a>'.format(url, u'export to mirror')
    export_to_mirror_link.allow_tags = True

    def get_urls(self):
        urls = super(IssueAdmin, self).get_urls()
        admin_urls = patterns(
            '',
            url(r'^export_to_mirror/(?P<issue_id>\d+)$', admin.site.admin_view(export_to_mirror),name="export_to_mirror")
        )
        return admin_urls + urls


