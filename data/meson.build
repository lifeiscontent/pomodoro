icon_sizes = ['16', '24', '32', '48', '64', '128']

foreach icon_size : icon_sizes
    install_data(
        join_paths('icons', icon_size + '.svg'),
        install_dir: join_paths(get_option('datadir'), 'icons', 'hicolor', icon_size + 'x' + icon_size, 'apps'),
        rename: meson.project_name() + '.svg'
    )
    install_data(
        join_paths('icons', icon_size + '.svg'),
        install_dir: join_paths(get_option('datadir'), 'icons', 'hicolor', icon_size + 'x' + icon_size + '@2', 'apps'),
        rename: meson.project_name() + '.svg'
    )
endforeach

i18n.merge_file (
    input: meson.project_name() + '.desktop.in',
    output: meson.project_name() + '.desktop',
    install: true,
    install_dir: join_paths(get_option('datadir'), 'applications'),
    po_dir: join_paths(meson.source_root (), 'po'),
    type: 'desktop'
)

i18n.merge_file (
    input: meson.project_name() + '.appdata.xml.in',
    output: meson.project_name() + '.appdata.xml',
    install: true,
    install_dir: join_paths(get_option('datadir'), 'metainfo'),
    po_dir: join_paths(meson.source_root (), 'po')
)
