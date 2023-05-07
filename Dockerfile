FROM osrf/ros:noetic-desktop

RUN apt update
RUN apt install -y locales software-properties-common curl
RUN add-apt-repository universe
RUN locale-gen en_GB en_GB.UTF-8
RUN update-locale LC_ALL=en_GB.UTF-8 LANG=en_GB.UTF-8
ENV LANG=en_GB.UTF-8

RUN curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null
RUN apt update
RUN apt upgrade -y
RUN apt install -y ros-foxy-ros-base ros-foxy-ros1-bridge python3-argcomplete 
EXPOSE 11311

COPY ./ros_entrypoint.sh /
COPY ./bridge.yaml /
COPY ./fastrtps-profile.xml /
ENV FASTRTPS_DEFAULT_PROFILES_FILE=/fastrtps-profile.xml

CMD [ "/ros_entrypoint.sh" ]
