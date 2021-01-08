executable(
    meson.project_name(),
    'Application.vala',
    dependencies: [
        dependency('gtk+-3.0')
    ],
    install: true
)

vala_lint = find_program('io.elementary.vala-lint', required : false)

if vala_lint.found()
    test (
        'Vala lint',
        vala_lint,
        args: ['-d', join_paths(meson.source_root(), 'src')]
    )
endif


