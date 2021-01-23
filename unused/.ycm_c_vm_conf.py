import os
import os.path
import fnmatch
import logging
import ycm_core
import re

# TODO: add more warnings
BASE_FLAGS = [
    '-Wall',
    '-Wextra',
    '-Wno-long-long',
    '-Wno-variadic-macros',
    '-fexceptions',
    '-ferror-limit=10000',
    '-DNDEBUG',
    '-std=gnu11',
    '-xc',
    '-I/usr/lib',
    '-I/usr/include',
    '-I/ws/tiamarin/halon/build-ridley/tmp/sysroots/x86_64-linux/usr/include',
    '-I/ws/tiamarin/halon/build-ridley/tmp/sysroots/ridley/usr/include',
    '-I/ws/tiamarin/halon/build-ridley/tmp/sysroots/ridley/usr/include/ovs',
    '-I/ws/tiamarin/halon/halon-src/ops-openvswitch/lib/',
    '-I/ws/tiamarin/halon/build-paramount/tmp/sysroots/paramount/usr/include/dune_sdk',
    '-I/ws/tiamarin/halon/halon-src/hpe-switchd-dune-plugin/dune_agent/addressing/include',
    '-I/ws/tiamarin/halon/halon-src/hpe-switchd-dune-plugin/dune_agent/agent_diag/include',
    '-I/ws/tiamarin/halon/halon-src/hpe-switchd-dune-plugin/dune_agent/agent_idl/include',
    '-I/ws/tiamarin/halon/halon-src/hpe-switchd-dune-plugin/dune_agent/agent_local_state/include',
    '-I/ws/tiamarin/halon/halon-src/hpe-switchd-dune-plugin/dune_agent/asic_init/include',
    '-I/ws/tiamarin/halon/halon-src/hpe-switchd-dune-plugin/dune_agent/bcm_shell/include',
    '-I/ws/tiamarin/halon/halon-src/hpe-switchd-dune-plugin/dune_agent/bfd/include',
    '-I/ws/tiamarin/halon/halon-src/hpe-switchd-dune-plugin/dune_agent/card_manager/include',
    '-I/ws/tiamarin/halon/halon-src/hpe-switchd-dune-plugin/dune_agent/copp/include',
    '-I/ws/tiamarin/halon/halon-src/hpe-switchd-dune-plugin/dune_agent/counters/counter_api/include',
    '-I/ws/tiamarin/halon/halon-src/hpe-switchd-dune-plugin/dune_agent/counters/ip_errors/include',
    '-I/ws/tiamarin/halon/halon-src/hpe-switchd-dune-plugin/dune_agent/cpurx/include',
    '-I/ws/tiamarin/halon/halon-src/hpe-switchd-dune-plugin/dune_agent/datapath_manager/include',
    '-I/ws/tiamarin/halon/halon-src/hpe-switchd-dune-plugin/dune_agent/fpga/include',
    '-I/ws/tiamarin/halon/halon-src/hpe-switchd-dune-plugin/dune_agent/fsm_card_agent/include',
    '-I/ws/tiamarin/halon/halon-src/hpe-switchd-dune-plugin/dune_agent/health_monitor/include',
    '-I/ws/tiamarin/halon/halon-src/hpe-switchd-dune-plugin/dune_agent/idl_scheduler/include',
    '-I/ws/tiamarin/halon/halon-src/hpe-switchd-dune-plugin/dune_agent/ipexception/include',
    '-I/ws/tiamarin/halon/halon-src/hpe-switchd-dune-plugin/dune_agent/knet/include',
    '-I/ws/tiamarin/halon/halon-src/hpe-switchd-dune-plugin/dune_agent/l1_ports/include',
    '-I/ws/tiamarin/halon/halon-src/hpe-switchd-dune-plugin/dune_agent/l3pdc/include',
    '-I/ws/tiamarin/halon/halon-src/hpe-switchd-dune-plugin/dune_agent/lag/include',
    '-I/ws/tiamarin/halon/halon-src/hpe-switchd-dune-plugin/dune_agent/ledup/include',
    '-I/ws/tiamarin/halon/halon-src/hpe-switchd-dune-plugin/dune_agent/link_scan/include',
    '-I/ws/tiamarin/halon/halon-src/hpe-switchd-dune-plugin/dune_agent/mac_table/include',
    '-I/ws/tiamarin/halon/halon-src/hpe-switchd-dune-plugin/dune_agent/mirror/include',
    '-I/ws/tiamarin/halon/halon-src/hpe-switchd-dune-plugin/dune_agent/multicast/include',
    '-I/ws/tiamarin/halon/halon-src/hpe-switchd-dune-plugin/dune_agent/mymac/include',
    '-I/ws/tiamarin/halon/halon-src/hpe-switchd-dune-plugin/dune_agent/policer/include',
    '-I/ws/tiamarin/halon/halon-src/hpe-switchd-dune-plugin/dune_agent/qos/include',
    '-I/ws/tiamarin/halon/halon-src/hpe-switchd-dune-plugin/dune_agent/range_checker/include',
    '-I/ws/tiamarin/halon/halon-src/hpe-switchd-dune-plugin/dune_agent/sflow/include',
    '-I/ws/tiamarin/halon/halon-src/hpe-switchd-dune-plugin/dune_agent/spanning_tree/include',
    '-I/ws/tiamarin/halon/halon-src/hpe-switchd-dune-plugin/dune_agent/tcam/include',
    '-I/ws/tiamarin/halon/halon-src/hpe-switchd-dune-plugin/dune_agent/thermal/include',
    '-I/ws/tiamarin/halon/halon-src/hpe-switchd-dune-plugin/dune_agent/tunnel/include',
    '-I/ws/tiamarin/halon/halon-src/hpe-switchd-dune-plugin/dune_agent/vlan/include',
    '-I/ws/tiamarin/halon/halon-src/hpe-switchd-dune-plugin/dune_agent/vsx/include',
    '-I/ws/tiamarin/halon/halon-src/hpe-switchd-dune-plugin/dune_plugin/addressing/include',
    '-I/ws/tiamarin/halon/halon-src/hpe-switchd-dune-plugin/dune_plugin/asic_init/asic-init-plugin/include',
    '-I/ws/tiamarin/halon/halon-src/hpe-switchd-dune-plugin/dune_plugin/asic_init/include',
    '-I/ws/tiamarin/halon/halon-src/hpe-switchd-dune-plugin/dune_plugin/bfd/include',
    '-I/ws/tiamarin/halon/halon-src/hpe-switchd-dune-plugin/dune_plugin/card_manager/include',
    '-I/ws/tiamarin/halon/halon-src/hpe-switchd-dune-plugin/dune_plugin/copp/include',
    '-I/ws/tiamarin/halon/halon-src/hpe-switchd-dune-plugin/dune_plugin/countermon/include',
    '-I/ws/tiamarin/halon/halon-src/hpe-switchd-dune-plugin/dune_plugin/counters/counter_api/include',
    '-I/ws/tiamarin/halon/halon-src/hpe-switchd-dune-plugin/dune_plugin/counters/include',
    '-I/ws/tiamarin/halon/halon-src/hpe-switchd-dune-plugin/dune_plugin/counters/ip_errors/include',
    '-I/ws/tiamarin/halon/halon-src/hpe-switchd-dune-plugin/dune_plugin/counters/l3_counters/include',
    '-I/ws/tiamarin/halon/halon-src/hpe-switchd-dune-plugin/dune_plugin/cpurx/include',
    '-I/ws/tiamarin/halon/halon-src/hpe-switchd-dune-plugin/dune_plugin/datapath_manager/include',
    '-I/ws/tiamarin/halon/halon-src/hpe-switchd-dune-plugin/dune_plugin/encap_mgr/include',
    '-I/ws/tiamarin/halon/halon-src/hpe-switchd-dune-plugin/dune_plugin/fpga/include',
    '-I/ws/tiamarin/halon/halon-src/hpe-switchd-dune-plugin/dune_plugin/include',
    '-I/ws/tiamarin/halon/halon-src/hpe-switchd-dune-plugin/dune_plugin/ipexception/include',
    '-I/ws/tiamarin/halon/halon-src/hpe-switchd-dune-plugin/dune_plugin/l3pdc/include',
    '-I/ws/tiamarin/halon/halon-src/hpe-switchd-dune-plugin/dune_plugin/mac_table/include',
    '-I/ws/tiamarin/halon/halon-src/hpe-switchd-dune-plugin/dune_plugin/mirror/include',
    '-I/ws/tiamarin/halon/halon-src/hpe-switchd-dune-plugin/dune_plugin/multicast/include',
    '-I/ws/tiamarin/halon/halon-src/hpe-switchd-dune-plugin/dune_plugin/qos/include',
    '-I/ws/tiamarin/halon/halon-src/hpe-switchd-dune-plugin/dune_plugin/sflow/include',
    '-I/ws/tiamarin/halon/halon-src/hpe-switchd-dune-plugin/dune_plugin/tunnel/include',
    '-I/ws/tiamarin/halon/halon-src/hpe-switchd-dune-plugin/dune_plugin/utils/include',
    '-I/ws/tiamarin/halon/halon-src/hpe-switchd-dune-plugin/dune_plugin/vsx/include',
    '-I/ws/tiamarin/halon/halon-src/hpe-switchd-dune-plugin/dune_remote_query/include',
    '-I/ws/tiamarin/halon/halon-src/hpe-switchd-dune-plugin/include',
    '-I/ws/tiamarin/halon/halon-src/hpe-switchd-dune-plugin/mm_lc_common/asic_init/include',
    '-I/ws/tiamarin/halon/halon-src/hpe-switchd-dune-plugin/mm_lc_common/bfd/include',
    '-I/ws/tiamarin/halon/halon-src/hpe-switchd-dune-plugin/mm_lc_common/card_manager/include',
    '-I/ws/tiamarin/halon/halon-src/hpe-switchd-dune-plugin/mm_lc_common/copp/include',
    '-I/ws/tiamarin/halon/halon-src/hpe-switchd-dune-plugin/mm_lc_common/counters/include',
    '-I/ws/tiamarin/halon/halon-src/hpe-switchd-dune-plugin/mm_lc_common/cpurx/include',
    '-I/ws/tiamarin/halon/halon-src/hpe-switchd-dune-plugin/mm_lc_common/health_monitor/include',
    '-I/ws/tiamarin/halon/halon-src/hpe-switchd-dune-plugin/mm_lc_common/include',
    '-I/ws/tiamarin/halon/halon-src/hpe-switchd-dune-plugin/mm_lc_common/l3pdc/include',
    '-I/ws/tiamarin/halon/halon-src/hpe-switchd-dune-plugin/mm_lc_common/lag/include',
    '-I/ws/tiamarin/halon/halon-src/hpe-switchd-dune-plugin/mm_lc_common/mac_table/include',
    '-I/ws/tiamarin/halon/halon-src/hpe-switchd-dune-plugin/mm_lc_common/mirror/include',
    '-I/ws/tiamarin/halon/halon-src/hpe-switchd-dune-plugin/mm_lc_common/multicast/include',
    '-I/ws/tiamarin/halon/halon-src/hpe-switchd-dune-plugin/mm_lc_common/qos/include',
    '-I/ws/tiamarin/halon/halon-src/hpe-switchd-dune-plugin/mm_lc_common/sflow/include',
    '-I/ws/tiamarin/halon/halon-src/hpe-switchd-dune-plugin/mm_lc_common/thermal/include',
    '-I/ws/tiamarin/halon/halon-src/hpe-switchd-dune-plugin/mm_lc_common/tunnel/include',
    '-I/ws/tiamarin/halon/halon-src/hpe-switchd-dune-plugin/mm_lc_common/utils/include',
    '-I/ws/tiamarin/halon/halon-src/hpe-switchd-dune-plugin/mm_lc_common/vlan/include',
    '-I/ws/tiamarin/halon/halon-src/hpe-switchd-dune-plugin/mm_lc_common/vsx/include',
    '-I/ws/tiamarin/halon/halon-src/hpe-switchd-dune-plugin/dune_plugin/include',
    '-I/ws/tiamarin/halon/halon-src/hpe-switchd-dune-plugin/bidi_cache/include',
]

#  '-I/ws/tiamarin/halon/halon-src/ops-openvswitch/include',
#  '-I/ws/tiamarin/halon/halon-src/hpe-eventlog/include',
#  '-I/ws/tiamarin/halon/halon-src/data-plane-defs/dune',
#  '-I/ws/tiamarin/halon/halon-src/ops-supportability/include/dlog',
#  '-I/ws/tiamarin/halon/halon-src/ops-supportability/include'

SOURCE_EXTENSIONS = [
    '.c',
    '.m',
    '.mm'
]

SOURCE_DIRECTORIES = [
    'src',
    'lib'
]

HEADER_EXTENSIONS = [
    '.h'
]

HEADER_DIRECTORIES = [
    'include'
]

BUILD_DIRECTORY = 'build'


def IsHeaderFile(filename):
    extension = os.path.splitext(filename)[1]
    return extension in HEADER_EXTENSIONS


def GetCompilationInfoForFile(database, filename):
    if IsHeaderFile(filename):
        basename = os.path.splitext(filename)[0]
        for extension in SOURCE_EXTENSIONS:
            # Get info from the source files by replacing the extension.
            replacement_file = basename + extension
            if os.path.exists(replacement_file):
                compilation_info = database.GetCompilationInfoForFile(
                    replacement_file)
                if compilation_info.compiler_flags_:
                    return compilation_info
            # If that wasn't successful, try replacing possible header directory with possible source directories.
            for header_dir in HEADER_DIRECTORIES:
                for source_dir in SOURCE_DIRECTORIES:
                    src_file = replacement_file.replace(header_dir, source_dir)
                    if os.path.exists(src_file):
                        compilation_info = database.GetCompilationInfoForFile(
                            src_file)
                        if compilation_info.compiler_flags_:
                            return compilation_info
        return None
    return database.GetCompilationInfoForFile(filename)


def FindNearest(path, target, build_folder=None):
    candidate = os.path.join(path, target)
    if(os.path.isfile(candidate) or os.path.isdir(candidate)):
        logging.info("Found nearest " + target + " at " + candidate)
        return candidate

    parent = os.path.dirname(os.path.abspath(path))
    if(parent == path):
        raise RuntimeError("Could not find " + target)

    if(build_folder):
        candidate = os.path.join(parent, build_folder, target)
        if(os.path.isfile(candidate) or os.path.isdir(candidate)):
            logging.info("Found nearest " + target +
                         " in build folder at " + candidate)
            return candidate

    return FindNearest(parent, target, build_folder)


def MakeRelativePathsInFlagsAbsolute(flags, working_directory):
    if not working_directory:
        return list(flags)
    new_flags = []
    make_next_absolute = False
    path_flags = ['-isystem', '-I', '-iquote', '--sysroot=']
    for flag in flags:
        new_flag = flag

        if make_next_absolute:
            make_next_absolute = False
            if not flag.startswith('/'):
                new_flag = os.path.join(working_directory, flag)

        for path_flag in path_flags:
            if flag == path_flag:
                make_next_absolute = True
                break

            if flag.startswith(path_flag):
                path = flag[len(path_flag):]
                new_flag = path_flag + os.path.join(working_directory, path)
                break

        if new_flag:
            new_flags.append(new_flag)
    return new_flags


def FlagsForInclude(root):
    try:
        include_path = FindNearest(root, 'include')
        flags = []
        for dirroot, dirnames, filenames in os.walk(include_path):
            for dir_path in dirnames:
                real_path = os.path.join(dirroot, dir_path)
                flags = flags + ["-I" + real_path]
        return flags
    except:
        return None


def FlagsForCompilationDatabase(root, filename):
    try:
        # Last argument of next function is the name of the build folder for
        # out of source projects
        compilation_db_path = FindNearest(
            root, 'compile_commands.json', BUILD_DIRECTORY)
        compilation_db_dir = os.path.dirname(compilation_db_path)
        logging.info("Set compilation database directory to " +
                     compilation_db_dir)
        compilation_db = ycm_core.CompilationDatabase(compilation_db_dir)
        if not compilation_db:
            logging.info("Compilation database file found but unable to load")
            return None
        compilation_info = GetCompilationInfoForFile(compilation_db, filename)
        if not compilation_info:
            logging.info("No compilation info for " +
                         filename + " in compilation database")
            return None
        return MakeRelativePathsInFlagsAbsolute(
            compilation_info.compiler_flags_,
            compilation_info.compiler_working_dir_)
    except:
        return None


def FlagsForFile(filename):
    root = os.path.realpath(filename)
    compilation_db_flags = FlagsForCompilationDatabase(root, filename)
    if compilation_db_flags:
        final_flags = compilation_db_flags
    else:
        final_flags = BASE_FLAGS
        include_flags = FlagsForInclude(root)
        if include_flags:
            final_flags = final_flags + include_flags
    return {
        'flags': final_flags,
        'do_cache': True
    }
